// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
//
// class PdfViewerPage extends StatefulWidget {
//   final String pdfPath;
//
//   const PdfViewerPage({super.key, required this.pdfPath});
//
//   @override
//   State<PdfViewerPage> createState() => _PdfViewerPageState();
// }
//
// class _PdfViewerPageState extends State<PdfViewerPage> {
//   final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SfPdfViewer.file(
//             File(widget.pdfPath),
//         key: _pdfViewerKey,
//         ));
//   }
//   }
