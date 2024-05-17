import 'package:flutter/material.dart';


class Doctors {
  String name;
  String address;
  String  designation;
  int age;
  String number;

  Doctors({required this.name, required this.address, required this.designation, required this.age, required this.number});
}

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {

  List<Doctors> doctors = [
    Doctors(name: 'Sourav barman', address: 'Joypurhat', designation:"MBBS", age: 25, number: '123-456-7890'),
    Doctors(name: 'Rana', address: 'Khulna', designation:"MBBS, BCS(Health)", age: 30, number: '987-654-3210'),
    Doctors(name: 'Mamun', address: '789 Oak St', designation:"MBBS", age: 28, number: '555-666-7777'),

    Doctors(name: 'John Doe', address: '123 Main St', designation:"MBBS, BCS(Health)", age: 25, number: '123-456-7890'),
    Doctors(name: 'Jane Smith', address: '456 Elm St', designation:"BDS", age: 30, number: '987-654-3210'),
    Doctors(name: 'Alice Johnson', address: '789 Oak St', designation:"MBBS", age: 28, number: '555-666-7777'),
    // Add 12 more patients here
  ];

  TextEditingController searchController = TextEditingController();
  List<Doctors> filteredPatients = [];
  @override
  void initState() {
    super.initState();
    filteredPatients = doctors;
  }

  void _addPatient(Doctors patient) {
    setState(() {
      doctors.add(patient);
      filteredPatients = doctors;
    });
  }


  void _filterPatients(String query) {
    final filtered = doctors.where((patient) {
      return patient.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredPatients = filtered;
    });
  }


  void _showAddPatientBottomSheet() {
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final designationController = TextEditingController();
    final ageController = TextEditingController();
    final numberController = TextEditingController();

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Doctor',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: designationController,
                  decoration: InputDecoration(
                    hintText: 'Designation',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    hintText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: numberController,
                  decoration: InputDecoration(
                    hintText: 'Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16.0),
                InkWell(
                  onTap: (){
                    final newPatient = Doctors(
                      name: nameController.text,
                      address: addressController.text,
                      designation: designationController.text,
                      age: int.parse(ageController.text),
                      number: numberController.text,
                    );
                    _addPatient(newPatient);
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(20), // Add borderRadius to InkWell
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade400,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        );
      },
    );
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
          title: const Text('Doctor List',style: TextStyle(
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
              InkWell(
                onTap: ()=>_showAddPatientBottomSheet(),
                borderRadius: BorderRadius.circular(20), // Add borderRadius to InkWell
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade400,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Text(
                    'Add Doctor',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Tapped on ${patient.name}')),
                          );
                        },
                        child: ListTile(
                          title: Text(patient.name,style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          )),
                          subtitle: Text('Age: ${patient.age}, Designation: ${patient.designation} \nAddress: ${patient.address}\nNumber: ${patient.number}',
                            style: const TextStyle(
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
