import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/src/features/scan/views/pdf_screen.dart';
// import 'package:mobile_app/src/features/scan/views/pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../../constant/app_text_style.dart';
import 'package:pdf/widgets.dart' as pw;
import 'brain_tumour_classify.dart';
import 'classification_result.dart';


class DottedBorderContainer extends StatefulWidget {
  const DottedBorderContainer({
    super.key,
  });

  @override
  State<DottedBorderContainer> createState() => _DottedBorderContainerState();
}

class _DottedBorderContainerState extends State<DottedBorderContainer> {

  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  File? _pdfFile;
  List<XFile> selectedImages = [];


  Future<void> pickImages(BuildContext context) async {
    // Request gallery access permission
    var status = await Permission.camera.request();

    if (status.isGranted) {
      final List<XFile> images = await _picker.pickMultiImage(
          imageQuality: 70);

      if (images.isNotEmpty) {
        setState(() {
          _selectedImages = images.map((image) => File(image.path)).toList();
        });

        await generatePdf();
      }
    } else {
      // Handle permission denial
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied')),
      );
    }
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    for (var imageFile in _selectedImages) {
      final image = pw.MemoryImage(imageFile.readAsBytesSync());
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(image),
        );
      }));
    }

    final tempDir = await getTemporaryDirectory();
    final pdfPath = '${tempDir.path}/images.pdf';
    final pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(await pdf.save());

    setState(() {
      _pdfFile = pdfFile;
    });
  }

  void viewPdf(BuildContext context) {
    if (_pdfFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFScreen(path: _pdfFile!.path),
        ),
      );
    }
  }


  Future<void> clearStoredData()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('imagePath');
    await prefs.remove('predictedLabel');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    clearStoredData();
    super.dispose();
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Scanning Image',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaint(
                  painter: DottedBorderPainter(),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BrainTumourClassification(),
                        ),
                      );
                    },
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.brain,
                                size: 80,
                                color: Colors.indigo.shade400,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Scan MRI Image',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomPaint(
                  painter: DottedBorderPainter(),
                  child: GestureDetector(
                    onTap: () {
                      pickImages(context);
                    },
                    child: Container(
                      height: 200,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.camera,
                                size: 80,
                                color: Colors.indigo.shade300,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Scan Prescription Image',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ClassificationResult(),
                          ),
                        );
                      },
                      child: Container(
                        height: 160,
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.image,
                              size: 50,
                              color: Colors.indigo.shade400,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'MRI Image',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=>viewPdf(context),
                      child: Container(
                        height: 160,
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.filePdf,
                              size: 50,
                              color: Colors.indigo.shade400,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Total Pages: ${_selectedImages.length}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade400,
                  minimumSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Submit Report',
                  style: AppTextStyle.textStyleOne(
                    Colors.white,
                    16,
                    FontWeight.w500,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 4;
    const double dashSpace = 4;
    double startX = 0;
    double startY = 0;

    final path = Path();
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(15));

    path.addRRect(rrect);

    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final Path extractPath =
            pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
