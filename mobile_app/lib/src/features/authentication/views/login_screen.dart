import 'package:flutter/material.dart';
import 'package:input_form_field/input_form_field.dart';

import '../../../constant/app_text_style.dart';
import '../../home/views/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailField = TextEditingController();
  final _passwordField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void login(){
    if(_formKey.currentState!.validate()) {
      if (_emailField.text == 'admin' && _passwordField.text == 'admin') {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const HomeScreen(),
        //   ),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }}


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            ),
            onPressed: (){
              Navigator.pop(context);
            },

          ),
        ),
       // bottomNavigationBar: const _Footer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome back to',
                      style: AppTextStyle.headLineOne,
                    ),
                    const Text(
                      'NeuroScan App',
                      style: AppTextStyle.headLineOne,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Please enter data to log in',
                      style: AppTextStyle.textStyleOne(
                        const Color(0xff838589),
                        15,
                        FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      'Phone',
                      style: AppTextStyle.smallTextTwo,
                    ),
                    const SizedBox(height: 20),
                    InputFormField(
                      borderRadius: BorderRadius.circular(10),
                      fillColor: const Color(0xfffafafa),
                      textEditingController: _emailField,
                     // validator: Validators.isValidEmail,
                      hintTextStyle: AppTextStyle.textStyleOne(
                        const Color(0xffC4C5C4),
                        14,
                        FontWeight.w400,
                      ),
                      hintText: 'Enter your Phone Number',
                      borderType: BorderType.none,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Password',
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,),
                    ),
                    const SizedBox(height: 20),
                    InputFormField(
                      borderRadius: BorderRadius.circular(10),
                      fillColor: const Color(0xfffafafa),
                      password: EnabledPassword(),
                      obscuringCharacter: '*',
                      textEditingController: _passwordField,
                     // validator: Validators.isValidPassword,
                      hintTextStyle: AppTextStyle.textStyleOne(
                        const Color(0xffC4C5C4),
                        14,
                        FontWeight.w400,
                      ),
                      hintText: 'Enter Account Password',
                      borderType: BorderType.none,
                    ),
                    const SizedBox(height: 80),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo.shade400,
                          minimumSize: const Size(400, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: AppTextStyle.textStyleOne(
                            Colors.white,
                            16,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
