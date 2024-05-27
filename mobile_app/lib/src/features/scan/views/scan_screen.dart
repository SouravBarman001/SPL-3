import 'package:flutter/material.dart';
import 'package:mobile_app/src/features/scan/views/scanning_image_screen.dart';


class Patient {
  String name;
  String address;
  double height;
  int age;
  String number;

  Patient({required this.name, required this.address, required this.height, required this.age, required this.number});
}

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  List<Patient> patients = [
    Patient(name: 'Sourav barman', address: 'Joypurhat', height: 5.8, age: 25, number: '123-456-7890'),
    Patient(name: 'Rana', address: 'Khulna', height: 5.5, age: 30, number: '987-654-3210'),
    Patient(name: 'Mamun', address: '789 Oak St', height:6.1, age: 28, number: '555-666-7777'),

    Patient(name: 'John Doe', address: '123 Main St', height: 5.8, age: 25, number: '123-456-7890'),
    Patient(name: 'Jane Smith', address: '456 Elm St', height: 5.5, age: 30, number: '987-654-3210'),
    Patient(name: 'Alice Johnson', address: '789 Oak St', height: 5.6, age: 28, number: '555-666-7777'),
    // Add 12 more patients here
  ];

  TextEditingController searchController = TextEditingController();
  List<Patient> filteredPatients = [];
  @override
  void initState() {
    super.initState();
    filteredPatients = patients;
  }

  void _addPatient(Patient patient) {
    setState(() {
      patients.add(patient);
      filteredPatients = patients;
    });
  }


  void _filterPatients(String query) {
    final filtered = patients.where((patient) {
      return patient.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredPatients = filtered;
    });
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: const Text('Select Patient',style: TextStyle(
            fontWeight: FontWeight.w600,
          ),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  suffixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: _filterPatients,
              ),
              const SizedBox(height: 16.0),
              const Text('Select a Patient to Scan Prescription & MRI',style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),),

              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredPatients.length,
                  itemBuilder: (context, index) {
                    final patient = filteredPatients[index];
                    return Card(
                      elevation: 2.0,
                      color: const Color(0xffEBF0F9),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Define what happens on tap

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('Tapped on ${patient.name}')),
                          // );

                       Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DottedBorderContainer()),
                       );

                        },
                        child: ListTile(
                          title: Text(" ${patient.name}",style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          )),
                          subtitle: const Text(" Patient ID: AAA-123 \n Assigned Doctor: Dr. John Doe",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
