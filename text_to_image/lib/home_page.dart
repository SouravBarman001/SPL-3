// home_page.dart
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:brain_fusion/brain_fusion.dart';
import 'ai_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  Uint8List? _imageData;
  bool _isLoading = false;

  final AIService _aiService = AIService();

  void _generateImage() async {
    setState(() {
      _isLoading = true;
    });

    Uint8List image = await _aiService.generateImage(_controller.text, AIStyle.anime);

    setState(() {
      _imageData = image;
      _isLoading = false;
    });
  }

  void _downloadImage() async {
    if (_imageData == null) return;

    final status = await Permission.storage.request();
    if (status.isGranted) {
      final directory = await getExternalStorageDirectory();
      final path = '${directory!.path}/generated_image.png';
      final file = File(path);
      await file.writeAsBytes(_imageData!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image downloaded to $path')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brain Fusion AI Image Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your prompt',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _generateImage,
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _imageData != null
                ? Column(
              children: [
                Image.memory(_imageData!),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _downloadImage,
                  child: Text('Download Image'),
                ),
              ],
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
