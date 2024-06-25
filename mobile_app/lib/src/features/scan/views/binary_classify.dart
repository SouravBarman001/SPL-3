import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tflite/tflite.dart';


class BinaryClassify extends StatefulWidget {
  const BinaryClassify({super.key});

  @override
  State<BinaryClassify> createState() => _BinaryClassifyState();
}

class _BinaryClassifyState extends State<BinaryClassify> with TickerProviderStateMixin {
  File? _image;

  late double _imageWidth;
  late double _imageHeight;
  bool _busy = false;
  final double _containerHeight = 0;

  late List _recognitions;
  final ImagePicker _picker = ImagePicker();

  late AnimationController _controller;
  static const List<IconData> icons = [Icons.camera_alt, Icons.image];

  final Map<String, int> _ingredients = {};
  String _selected = "";

  bool _isLoading = false;

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

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

  loadModel() async {
    Tflite.close();
    try {
      String res = await Tflite.loadModel(
        model: "assets/tflite/model.txt.tflite",
        labels: "assets/tflite/model.txt.txt",
      ) ?? '';
    } on PlatformException {
      print("Failed to load the model.txt");
    }
  }

  selectFromImagePicker({required bool fromCamera}) async {
    XFile? pickedFile = (fromCamera
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery));
    late var image = File(pickedFile!.path);
    setState(() {
      _busy = true;
    });
    predictImage(image);
  }

  predictImage(File image) async {
    _setLoading(true);

    await classify(image);

    FileImage(image)
        .resolve(const ImageConfiguration(size: Size(256, 256)))
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _imageWidth = info.image.width.toDouble();
        _imageHeight = info.image.height.toDouble();
      });
    })));

    setState(() {
      _image = image;
      _busy = false;
    });

    _setLoading(false);
  }

  classify(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: false // defaults to true
    );
    setState(() {
      _recognitions = recognitions ?? [];
    });
  }

  _imagePreview(File image) {
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
                child: Text('Detected Objects',
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _recognitions.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: RadioListTile<String>(
                          activeColor: Theme.of(context).primaryColor,
                          groupValue: _selected,
                          value: _recognitions[index]['label'],
                          onChanged: (String? value) {
                            if (_selected == value) {
                              setState(() {
                                _selected = '';
                              });
                            } else {
                              setState(() {
                                _selected = value!;
                              });
                            }
                          },
                          title: Text(_recognitions[index]['label'],
                              style: const TextStyle(fontSize: 16.0)),
                          subtitle: Text(
                              '${(_recognitions[index]["confidence"] * 100).toStringAsFixed(0)}%')));
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
      progressIndicator:
      SpinKitWanderingCubes(color: Theme.of(context).primaryColor),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Classify Object'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.image, color: Theme.of(context).primaryColor),
                onPressed: () {
                  selectFromImagePicker(fromCamera: false);
                },
              ),
              IconButton(
                icon: Icon(Icons.camera_alt,
                    color: Theme.of(context).primaryColor),
                onPressed: () {
                  selectFromImagePicker(fromCamera: true);
                },
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: _content(_image)),
    );
  }

  _content(File? image) {
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
                  child: Text('No Image',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                )),
            Center(
              child: Text('Image you pick will appear here.',
                  style: TextStyle(color: Colors.grey)),
            )
          ]);
    } else {
      return _imagePreview(image);
//      return Container();
    }
  }
}