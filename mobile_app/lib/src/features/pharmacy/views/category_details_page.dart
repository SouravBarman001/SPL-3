import 'package:flutter/material.dart';

import '../../../data/models/Medicine.dart';
import 'medicine_details_page.dart';

class CategoryDetailsPage extends StatelessWidget {
  final String category;

  const CategoryDetailsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Sample list of medicines
    final List<Medicine> medicines = [
      Medicine(
        name: 'Paracetamol',
        category: 'Analgesics',
        image: 'https://media.istockphoto.com/id/1359178154/photo/acetaminophen-ibuprofeno-pill-box-box-paper-blister-tablets.jpg?s=612x612&w=0&k=20&c=rLMJ3W3zEQoig3A-R9yGbnQKjWKXua6NvnX0JbZcpwg=',
        usages: 'Pain relief and fever reduction',
        effect: 'Mild side effects like nausea or allergic reactions',
        treatmentProcedure: 'Take one tablet every 4-6 hours as needed.',
      ),
      Medicine(
        name: 'Amoxicillin',
        category: 'Antibiotics',
        image: 'https://5.imimg.com/data5/SELLER/Default/2022/12/LL/JW/ST/108376694/cipmox-amoxicillin-500mg-capsules-500x500.png',
        usages: 'Treatment of bacterial infections',
        effect: 'Possible gastrointestinal upset or allergic reactions',
        treatmentProcedure: 'Take one capsule three times a day for 7 days.',
      ),
      // Add more medicines as needed
    ].where((medicine) => medicine.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Medicines'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: medicines.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
        itemBuilder: (context, index) {
          final medicine = medicines[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MedicineDetailsPage(medicine: medicine)),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(medicine.image, height: 100, width: double.infinity, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(medicine.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
