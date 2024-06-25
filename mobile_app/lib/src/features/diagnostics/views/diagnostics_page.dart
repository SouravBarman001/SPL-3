import 'package:flutter/material.dart';

import '../../../data/models/patient_model.dart';
import 'diagnostics_patient_report.dart';

class DiagnosticsPage extends StatefulWidget {
  const DiagnosticsPage({super.key});

  @override
  State<DiagnosticsPage> createState() => _DiagnosticsPageState();
}

class _DiagnosticsPageState extends State<DiagnosticsPage> {

  List<PatientModel> patients = [
    PatientModel(name: 'Sourav Barman', address: 'Joypurhat', height: 5.8, age: 25, number: '123-456-7890'),
    PatientModel(name: 'Rana', address: 'Khulna', height: 5.5, age: 30, number: '987-654-3210'),
    PatientModel(name: 'Mamun', address: '789 Oak St', height: 6.1, age: 28, number: '555-666-7777'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnostics'),
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(patients[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiagnosticsPatientReport(patient: patients[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
