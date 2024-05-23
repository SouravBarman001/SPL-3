import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



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

  // generate more random color


  // List of specialist names
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
        title: const Text('Find the right specialist',style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
        ),),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        //  margin: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:1,
            crossAxisSpacing: 22.0,
            mainAxisSpacing: 20.0,
          ),
          itemCount: icons.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icons[index],
                    size: 48.0,
                    color: Colors.blue.shade400,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    specialistNames[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
