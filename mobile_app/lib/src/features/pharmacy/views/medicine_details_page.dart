import 'package:flutter/material.dart';

import '../../../data/models/Medicine.dart';


class MedicineDetailsPage extends StatelessWidget {
  final Medicine medicine;

  const MedicineDetailsPage({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(medicine.image, height: 200, width: double.infinity, fit: BoxFit.cover),
              const SizedBox(height: 20),
              Text(medicine.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('Category: ${medicine.category}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              const Text('Usages:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(medicine.usages, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              const Text('Effect:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(medicine.effect, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              const Text('Treatment Procedure:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(medicine.treatmentProcedure, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
