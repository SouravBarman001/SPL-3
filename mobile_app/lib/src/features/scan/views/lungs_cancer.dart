import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tflite/tflite.dart';

class LungsCancer extends StatefulWidget {
  const LungsCancer({super.key});

  @override
  State<LungsCancer> createState() => _LungsCancerState();
}

class _LungsCancerState extends State<LungsCancer> with TickerProviderStateMixin {
  File? _image;
  bool _busy = false;
  bool _isLoading = false;
  late List _recognitions = [];
  final ImagePicker _picker = ImagePicker();

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Future<void> loadModel() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/tflite/lungs_cancer.tflite",
        labels: "assets/tflite/lungs_cancer.txt",
      );
      print("Model loaded: $res");
    } on PlatformException {
      print("Failed to load the model.txt");
    }
  }

  Future<void> selectFromImagePicker({required bool fromCamera}) async {
    XFile? pickedFile = await (fromCamera
        ? _picker.pickImage(source: ImageSource.camera)
        : _picker.pickImage(source: ImageSource.gallery));
    if (pickedFile == null) return;

    var image = File(pickedFile.path);
    setState(() {
      _busy = true;
    });
    await predictImage(image);
  }

  Future<void> predictImage(File image) async {
    setState(() {
      _isLoading = true;
    });

    await classify(image);

    setState(() {
      _image = image;
      _busy = false;
      _isLoading = false;
    });
  }

  Future<void> classify(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 4, // Adjusted for brain tumor labels
      threshold: 0.2,
      asynch: true,
    );

    setState(() {
      _recognitions = recognitions ?? [];
    });
  }

  Widget _imagePreview(File image) {
    _controller.reverse();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 7,
          child: ListView(
            children: <Widget>[
              Image.file(image),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Detected Tumors',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _recognitions.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        _recognitions[index]['label'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      subtitle: Text(
                        '${(_recognitions[index]["confidence"] * 100).toStringAsFixed(0)}%',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: SpinKitWanderingCubes(color: Theme.of(context).primaryColor),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Classify Brain Tumor'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.image, color: Theme.of(context).primaryColor),
              onPressed: () {
                selectFromImagePicker(fromCamera: false);
              },
            ),
            IconButton(
              icon: Icon(Icons.camera_alt, color: Theme.of(context).primaryColor),
              onPressed: () {
                selectFromImagePicker(fromCamera: true);
              },
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: _content(_image),
      ),
    );
  }

  Widget _content(File? image) {
    if (image == null) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.image, size: 100.0, color: Colors.grey),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'No Image',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              'Image you pick will appear here.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      );
    } else {
      return _imagePreview(image);
    }
  }
}
