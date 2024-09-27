import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/app_text_style.dart';

class ClassificationResult extends StatefulWidget {
  const ClassificationResult({super.key});

  @override
  State<ClassificationResult> createState() => _ClassificationResultState();
}

class _ClassificationResultState extends State<ClassificationResult> {
  String _imagePath = '';
  String _predictedLabel = '';

  final Map<String, String> tumorInfo = {
    'glioma_tumor': 'Gliomas are tumors that arise from glial cells in the brain. '
        'Treatment options include surgery, radiation therapy, and chemotherapy. '
        'Common medicines include Temozolomide and Bevacizumab.',
    'meningioma_tumor': 'Meningiomas are tumors that arise from the meninges, the membranes that surround the brain and spinal cord. '
        'Treatment options include observation, surgery, and radiation therapy. '
        'Common medicines include Dexamethasone and Hydroxyurea.',
    'pituitary_tumor': 'Pituitary tumors are abnormal growths in the pituitary gland. '
        'Treatment options include surgery, radiation therapy, and medication. '
        'Common medicines include Cabergoline and Bromocriptine.',
    'no_tumor': 'No tumor detected. No treatment required.',
  };

  @override
  void initState() {
    super.initState();
    loadReport();
  }

  Future<void> loadReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('imagePath') ?? '';
      _predictedLabel = prefs.getString('predictedLabel') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classification Result'),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: _imagePath.isEmpty
          ? const Center(child: Text('No report available.'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.file(
                File(_imagePath),
                height: 300.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              _predictedLabel.replaceAll('_', ' ').toUpperCase(),
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            if (_predictedLabel != 'no_tumor')
              Text(
                tumorInfo[_predictedLabel]!,
                style: const TextStyle(fontSize: 16.0),
                textAlign: TextAlign.justify,
              ),

            SizedBox(height: 60.0),
            Center(
              child: ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade400,
                  minimumSize: const Size(255, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Sends Report',
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
