import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'appointment_submit_screen.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final List<IconData> icons = [
    FontAwesomeIcons.stethoscope,     // General Physician
    FontAwesomeIcons.deaf,             // Ear Nose & Throat
    FontAwesomeIcons.brain,            // Neurologist
    FontAwesomeIcons.dna,              // Endocrinologist
    FontAwesomeIcons.baby,             // Pediatrician
    FontAwesomeIcons.syringe,          // Dermatologist
    FontAwesomeIcons.eye,              // Ophthalmologist
    FontAwesomeIcons.female,           // Gynecologist
    FontAwesomeIcons.dumbbell,         // Physiotherapist
    FontAwesomeIcons.userMd,           // Psychiatrist
  ];

  // List of specialist names
  final List<String> specialistNames = [
    "General Physician",
    "Ear Nose & Throat",
    "Neurologist",
    "Endocrinologist",
    "Pediatrician",
    "Dermatologist",
    "Ophthalmologist",
    "Gynecologist",
    "Physiotherapist",
    "Psychiatrist",
  ];

  // List of specialist colors
  final List<Color> colors = [
    const Color(0xff63bad4),
    const Color(0xffFCCAC9),
    const Color(0xffF7AD79),
    const Color(0xffFFDB7D),
    const Color(0xff63bad4),
    const Color(0xffFCCAC9),
    const Color(0xffF7AD79),
    const Color(0xffFFDB7D),
    const Color(0xff63bad4),
    const Color(0xffFCCAC9),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Find the right specialist',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: icons.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                // Navigate to the next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DoctorAppointmentPage(),
                  ),
                );

              },
              child: Container(
                alignment: Alignment.center,
                height: 70.0,
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Icon(
                    icons[index],
                    size: 30.0,
                    color: Colors.blue.shade400,
                  ),
                  title: Text(
                    specialistNames[index],
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
