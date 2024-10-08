import 'package:flutter/material.dart';
import 'package:mobile_app/src/features/scan/views/image_classfication_page.dart';

class AddUserScreen extends StatelessWidget {
  AddUserScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Patient Information',style: TextStyle(
        fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: nameController,
                hintText: 'Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 16.0),
              _buildTextField(
                controller: addressController,
                hintText: 'Address',
                icon: Icons.home,
              ),
              const SizedBox(height: 16.0),
              _buildTextField(
                controller: numberController,
                hintText: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16.0),
              _buildTextField(
                controller: weightController,
                hintText: 'Weight (kg)',
                icon: Icons.fitness_center,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              _buildTextField(
                controller: bloodGroupController,
                hintText: 'Blood Group',
                icon: Icons.bloodtype,
              ),
              const SizedBox(height: 16.0),
              _buildTextField(
                controller: emailController,
                hintText: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {

                    // Collect user data
                    final name = nameController.text;
                    final address = addressController.text;
                    final number = numberController.text;
                    final weight = weightController.text;
                    final bloodGroup = bloodGroupController.text;
                    final email = emailController.text;

                    // Navigate to the next screen with user info
                    if(name.isEmpty && address.isEmpty && number.isEmpty && weight.isEmpty && bloodGroup.isEmpty && email.isEmpty){

                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageClassificationPage(
                            userInfo: {
                              'name': name,
                              'address': address,
                              'number': number,
                              'weight': weight,
                              'bloodGroup': bloodGroup,
                              'email': email,
                            },
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
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
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
      keyboardType: keyboardType,
    );
  }
}
