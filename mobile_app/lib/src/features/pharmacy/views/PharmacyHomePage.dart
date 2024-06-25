import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../data/models/Medicine.dart';

import 'category_details_page.dart';
import 'medicine_details_page.dart';

class PharmacyHomePage extends StatefulWidget {
  const PharmacyHomePage({super.key});

  @override
  State<PharmacyHomePage> createState() => _PharmacyHomePageState();
}

class _PharmacyHomePageState extends State<PharmacyHomePage> {
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 200.0, autoPlay: true),
              items: [
                'https://st3.depositphotos.com/1500360/33756/i/450/depositphotos_337561080-stock-photo-medical-banner-design-with-pediatric.jpg',
                'https://img.freepik.com/premium-vector/creative-medical-healthcare-web-banner-template_642592-1069.jpg',
                'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/visiting-card-for-doctor-design-template-d0e4a6e8e2e6bc3478e7ffce6da01eaa_screen.jpg?ts=1614319554'
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(i, fit: BoxFit.cover, width: double.infinity);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryCard(context, 'Anesthetics', Icons.local_hospital, 'anesthetics.png'),
                  _buildCategoryCard(context, 'Analgesics', Icons.healing, 'analgesics.png'),
                  _buildCategoryCard(context, 'Antibiotics', Icons.medical_services, 'antibiotics.png'),
                  _buildCategoryCard(context, 'Antifungal', Icons.grass, 'antifungal.png'),
                  _buildCategoryCard(context, 'Antihistamines', Icons.science, 'antihistamines.png'),
                  _buildCategoryCard(context, 'Antineoplastic', Icons.biotech, 'antineoplastic.png'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Medicines',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildMedicinesGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryDetailsPage(category: title)),
        );
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicinesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(medicine.category, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
