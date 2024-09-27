// appointment_dialog.dart

import 'package:flutter/material.dart';

import 'appointment_submit_screen.dart';


class AppointmentDialog extends StatefulWidget {
  final Doctor doctor;
  final List<Patient> patients;

  const AppointmentDialog({super.key, required this.doctor, required this.patients});

  @override
  _AppointmentDialogState createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<AppointmentDialog> {
  TextEditingController _searchController = TextEditingController();
  List<Patient> _filteredPatients = [];

  @override
  void initState() {
    super.initState();
    _filteredPatients = widget.patients;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // Function to handle search input changes
  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPatients = widget.patients
          .where((patient) => patient.name.toLowerCase().contains(query))
          .toList();
    });
  }

  // Function to handle appointment button press
  void _makeAppointment(String patientName) {
    // Here, you can handle the appointment logic (e.g., save to database)
    Navigator.of(context).pop(); // Close the dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointment made with $patientName'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          // Adjust the height as needed
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Appointment with ${widget.doctor.fullName}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search Patient',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: _filteredPatients.isNotEmpty
                    ? ListView.builder(
                  itemCount: _filteredPatients.length,
                  itemBuilder: (context, index) {
                    final patient = _filteredPatients[index];
                    return ListTile(
                      title: Text(patient.name),
                      onTap: () => _makeAppointment(patient.name),
                    );
                  },
                )
                    : Center(
                  child: Text('No patients found'),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      String patientName = _searchController.text.trim();
                      if (patientName.isNotEmpty) {
                        _makeAppointment(patientName);
                      } else {
                        // Show error if no name entered
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter a patient name'),
                          ),
                        );
                      }
                    },
                    child: Text('Make Appointment'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
