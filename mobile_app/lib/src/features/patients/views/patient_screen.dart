// patient_screen.dart

import 'package:flutter/material.dart';

import '../../../data/repository/local_repo/db_helper.dart';
import '../../../data/models/models.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();


  List<Patient> patients = [];
  List<Patient> filteredPatients = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshPatients();
    searchController.addListener(_filterPatients);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterPatients);
    searchController.dispose();
    super.dispose();
  }

  // Fetch patients from the database
  Future<void> _refreshPatients() async {
    final data = await _dbHelper.getPatients();
    setState(() {
      patients = data;
      filteredPatients = data;
    });
  }

  // Filter patients based on search query
  void _filterPatients() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredPatients = patients.where((patient) {
        return patient.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  // Add a new patient to the database
  Future<void> _addPatient(Patient patient) async {
    await _dbHelper.insertPatient(patient);
    _refreshPatients();
  }

  // Update an existing patient
  Future<void> _updatePatient(Patient patient) async {
    await _dbHelper.updatePatient(patient);
    _refreshPatients();
  }

  // Delete a patient
  Future<void> _deletePatient(int id) async {
    await _dbHelper.deletePatient(id);
    _refreshPatients();
  }

  // Show the Add/Edit Patient Bottom Sheet
  void _showAddEditPatientBottomSheet({Patient? patient}) {
    final nameController = TextEditingController(text: patient?.name ?? '');
    final addressController = TextEditingController(text: patient?.address ?? '');
    final heightController =
    TextEditingController(text: patient != null ? patient.height.toString() : '');
    final ageController =
    TextEditingController(text: patient != null ? patient.age.toString() : '');
    final numberController = TextEditingController(text: patient?.number ?? '');

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true, // To make the bottom sheet scrollable when keyboard appears
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
                Text(
                  patient == null ? 'Add Patient' : 'Edit Patient',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: nameController,
                  hintText: 'Name',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: addressController,
                  hintText: 'Address',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: heightController,
                  hintText: 'Height (ft)',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: ageController,
                  hintText: 'Age',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: numberController,
                  hintText: 'Number',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16.0),
                InkWell(
                  onTap: () {
                    if (_validatePatientInput(
                        nameController,
                        addressController,
                        heightController,
                        ageController,
                        numberController)) {
                      final newPatient = Patient(
                        id: patient?.id,
                        name: nameController.text,
                        address: addressController.text,
                        height: double.parse(heightController.text),
                        age: int.parse(ageController.text),
                        number: numberController.text,
                      );
                      if (patient == null) {
                        _addPatient(newPatient);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Patient ${newPatient.name} added')),
                        );
                      } else {
                        _updatePatient(newPatient);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Patient ${newPatient.name} updated')),
                        );
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: double.infinity,
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
                    child: Text(
                      patient == null ? 'Add' : 'Update',
                      style: const TextStyle(
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

  // Build a reusable TextField widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
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
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      ),
      keyboardType: keyboardType,
    );
  }

  // Validate patient input fields
  bool _validatePatientInput(
      TextEditingController name,
      TextEditingController address,
      TextEditingController height,
      TextEditingController age,
      TextEditingController number) {
    if (name.text.isEmpty ||
        address.text.isEmpty ||
        height.text.isEmpty ||
        age.text.isEmpty ||
        number.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
      return false;
    }
    if (double.tryParse(height.text) == null ||
        int.tryParse(age.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid numbers for height and age'),
        ),
      );
      return false;
    }
    return true;
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
          title: const Text(
            'Patient List',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Search Bar
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search Patients',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  suffixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                    BorderSide(color: Colors.grey.shade300, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                    const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (value) => _filterPatients(),
              ),
              const SizedBox(height: 16.0),
              // Add Patient Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () => _showAddEditPatientBottomSheet(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Patient'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                    primary: Colors.indigo.shade400,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Patients Grid
              Expanded(
                child: filteredPatients.isNotEmpty
                    ? GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items per row
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.1, // Adjust the ratio to control tile size
                  ),
                  itemCount: filteredPatients.length,
                  itemBuilder: (context, index) {
                    final patient = filteredPatients[index];
                    return Card(
                      elevation: 2.0,
                      color: const Color(0xffEBF0F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Patient Name and Actions
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    patient.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // Update Button
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    _showAddEditPatientBottomSheet(patient: patient);
                                  },
                                ),
                                // Delete Button
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    // Confirm deletion
                                    bool? confirm = await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Delete Patient'),
                                        content: const Text(
                                            'Are you sure you want to delete this patient?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(false),
                                            child: const Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text('Delete'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirm == true) {
                                      await _deletePatient(patient.id!);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Deleted ${patient.name}'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // Patient Details
                            Text(
                              'Age: ${patient.age}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              'Height: ${patient.height} ft',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const Spacer(),
                            Text(
                              'Address: ${patient.address}',
                              style: const TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Phone: ${patient.number}',
                              style: const TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
                    : const Center(
                  child: Text(
                    'No patients found.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
