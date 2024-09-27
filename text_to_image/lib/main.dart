// // main.dart
// import 'package:flutter/material.dart';
// import 'home_page.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Brain Fusion AI',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }





import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:brain_fusion/brain_fusion.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AI ai = AI();

  MyApp({super.key});

  Future<Uint8List> generate(String query) async {
    Uint8List image = await ai.runAI(query, AIStyle.anime);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Brain Fusion Example'),
        ),
        body: Center(
          child: brainFusion(),
        ),
      ),
    );
  }

  Widget brainFusion() {
    return FutureBuilder<Uint8List>(
      // Call the generate() function to get the image data
      future: generate('YOUR TEXT'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the image data, display a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If an error occurred while getting the image data, display an error
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // If the image data is available, display the image using Image.memory()
          return Image.memory(snapshot.data!);
        } else {
          // If no data is available, display a placeholder or an empty container
          return Container();
        }
      },
    );
  }
}
