import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class ImageClassificationPage extends StatefulWidget {
  const ImageClassificationPage({super.key});

  @override
  State<ImageClassificationPage> createState() => _ImageClassificationPageState();

}

class _ImageClassificationPageState extends State<ImageClassificationPage> {
  File? _image;
  String? _predictedClass;
  double? _accuracy;
  final picker = ImagePicker();
  bool _loading = false;

  // Flask server URL
  final String flaskServerUrl = 'http://10.0.2.2:5000/classify'; // Replace with your server URL

  // Function to pick an image from the gallery or take a picture using the camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _uploadImage(_image!);
    }
  }

  // Function to send the image to the Flask server
  Future<void> _uploadImage(File imageFile) async {
    setState(() {
      _loading = true;
    });
    try {
      var request = http.MultipartRequest('POST', Uri.parse(flaskServerUrl));
      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        setState(() {
          _predictedClass = jsonResponse['predicted_class'];
          _accuracy = jsonResponse['accuracy'];
          _loading = false;
        });
      } else {
        print('Failed to get prediction');
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      print('Error occurred while sending image: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Classification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              Image.file(
                _image!,
                height: 200,
                width: 200,
              )
            else
              const Placeholder(
                fallbackHeight: 200,
                fallbackWidth: 200,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: const Text('Select Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: const Text('Take a Picture'),
            ),
            SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (_predictedClass != null && _accuracy != null)
              Column(
                children: [
                  Text(
                    'Predicted Class: $_predictedClass',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Accuracy: ${_accuracy!.toStringAsFixed(2)}%',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}