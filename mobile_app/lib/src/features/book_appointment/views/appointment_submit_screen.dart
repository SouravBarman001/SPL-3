import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'appointment_dialog.dart';

// models.dart

// models.dart

import 'package:flutter/material.dart';

class Doctor {
  final String fullName;
  final String qualifications;
  final String role;
  final IconData icon;

  Doctor({
    required this.fullName,
    required this.qualifications,
    required this.role,
    required this.icon,
  });
}

class Patient {
  final String name;

  Patient({required this.name});
}



class DoctorAppointmentPage extends StatefulWidget {
  const DoctorAppointmentPage({super.key});

  @override
  State<DoctorAppointmentPage> createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {

  final List<Doctor> doctors = [
    Doctor(
      fullName: 'Prof. (Col.) Dr. Md. Aminul Islam, MBBS, MS (Neurosurgery)',
      qualifications:
      'Fellow NNI, Singapore\nFellow Micro-neurosurgery, KEM Hospital, Mumbai, India\nFellowship in Endo-neurosurgery, Jabalpur, India',
      role: 'Senior Consultant',
      icon: FontAwesomeIcons.userMd,
    ),
    Doctor(
      fullName: 'Dr. Jane Doe, MBBS, MD (Cardiology)',
      qualifications:
      'Fellow American Heart Association\nResearcher in Cardiac Electrophysiology',
      role: 'Consultant Cardiologist',
      icon: FontAwesomeIcons.userMd,
    ),
    // Add more doctors as needed
    Doctor(
      fullName: 'Dr. John Smith, MBBS, MS (Orthopedics)',
      qualifications:
      'Fellow International Orthopedic Association\nResearcher in Joint Replacement',
      role: 'Senior Orthopedic Surgeon',
      icon: FontAwesomeIcons.userMd,
    ),
    Doctor(
      fullName: 'Dr. Emily Davis, MBBS, MD (Pediatrics)',
      qualifications:
      'Fellow Pediatric Society\nExpert in Neonatology',
      role: 'Consultant Pediatrician',
      icon: FontAwesomeIcons.userMd,
    ),
    Doctor(
      fullName: 'Dr. Sarah Lee, MBBS, MD (Cardiology)',
      qualifications:
      'Fellow American College of Cardiology\nSpecialist in Interventional Cardiology',
      role: 'Senior Cardiologist',
      icon: FontAwesomeIcons.heartbeat,
    ),
    Doctor(
      fullName: 'Dr. David Patel, MBBS, MS (Neurology)',
      qualifications:
      'Fellow Neurological Society\nResearcher in Stroke and Epilepsy',
      role: 'Consultant Neurologist',
      icon: FontAwesomeIcons.brain,
    ),
    Doctor(
      fullName: 'Dr. Olivia Brown, MBBS, MS (Dermatology)',
      qualifications:
      'Member Dermatological Association\nSpecialist in Cosmetic Dermatology',
      role: 'Senior Dermatologist',
      icon: FontAwesomeIcons.syringe,
    ),
    Doctor(
      fullName: 'Dr. Michael Wang, MBBS, MS (Ophthalmology)',
      qualifications:
      'Member Ophthalmic Surgeons Association\nSpecialist in Cataract and LASIK Surgery',
      role: 'Consultant Ophthalmologist',
      icon: FontAwesomeIcons.eye,
    ),


    // ... add other doctors
  ];


  // Sample list of patients
  final List<Patient> patients = [
    Patient(name: 'Alice Johnson'),
    Patient(name: 'Bob Smith'),
    Patient(name: 'Charlie Davis'),
    Patient(name: 'Diana Evans'),
    Patient(name: 'Ethan Harris'),
    Patient(name: 'Fiona Clark'),
    Patient(name: 'George Lewis'),
    Patient(name: 'Hannah Walker'),
    // Add more patients as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: doctors.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75, // Adjust as needed
          ),
          itemBuilder: (context, index) {
            final doctor = doctors[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: FaIcon(
                        doctor.icon,
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      doctor.fullName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      doctor.qualifications,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      doctor.role,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Function to show the appointment dialog
  // Function to show the appointment dialog
  void _showAppointmentDialog(Doctor doctor) {
    showDialog(
      context: context,
      builder: (context) {
        return AppointmentDialog(
          doctor: doctor,
          patients: patients,
        );
      },
    );
  }


}
