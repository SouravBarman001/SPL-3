import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/patient_model.dart';

class DiagnosticsPatientReport extends StatelessWidget {
  final PatientModel patient;
  const DiagnosticsPatientReport({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${patient.name}\'s Report'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Info',),
              Tab(text: 'Scan Result'),
              Tab(text: 'Prescription'),
              Tab(text: 'Medicines'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PatientInfoTab(patient: patient),
            const BrainTumourTab(),
            const PrescriptionPdfTab(),
            const MedicinesTab(),
          ],
        ),
      ),
    );
  }
}

class PatientInfoTab extends StatelessWidget {
  final PatientModel patient;
  const PatientInfoTab({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${patient.name}'),
          Text('Address: ${patient.address}'),
          Text('Height: ${patient.height}'),
          Text('Age: ${patient.age}'),
          Text('Number: ${patient.number}'),
        ],
      ),
    );
  }
}

class BrainTumourTab extends StatelessWidget {
  const BrainTumourTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement as per ClassificationResult page
    return Container(); // Placeholder
  }
}

class PrescriptionPdfTab extends StatelessWidget {
  const PrescriptionPdfTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _getPdfFile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return PDFView(
              filePath: snapshot.data!.path,
            );
          } else {
            return const Center(child: Text('Error loading PDF'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<File> _getPdfFile() async {
    final tempDir = await getTemporaryDirectory();
    final pdfPath = '${tempDir.path}/images.pdf';
    final pdfFile = File(pdfPath);
    return pdfFile;
  }
}

class MedicinesTab extends StatefulWidget {
  const MedicinesTab({super.key});

  @override
  State<MedicinesTab> createState() => _MedicinesTabState();
}

class _MedicinesTabState extends State<MedicinesTab> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _medicines = ['Paracetamol', 'Aspirin', 'Amoxicillin'];
  final List<String> _selectedMedicines = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Search Medicine',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    if (_controller.text.isNotEmpty && !_selectedMedicines.contains(_controller.text)) {
                      _selectedMedicines.add(_controller.text);
                    }
                    _controller.clear();
                  });
                },
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _selectedMedicines.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_selectedMedicines[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _selectedMedicines.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
