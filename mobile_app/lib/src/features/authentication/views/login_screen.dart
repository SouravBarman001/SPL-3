import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:input_form_field/input_form_field.dart';
import 'package:mobile_app/src/features/home/views/home_screen.dart';
import '../../../constant/app_text_style.dart';
import '../../home/views/my_home_screen.dart';
import '../controllers/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailField = TextEditingController();
  final _passwordField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

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
            builder: (context) => const MyHomeScreen(),
          ),
        );
      }
    }}

.nstu@gmail.com
   _login(BuildContext context)async{
    await _auth.signInWithEmailAndPassword(email: _emailField.text, password: _passwordField.text).then((value) {
      if(value != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomeScreen()));
      }
    });

   }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();



  Future<void> checkSignInStatus(BuildContext context) async {
    try {
      final googleUser = _googleSignIn.currentUser;

      if (googleUser != null) {
        // User is already signed in
        print("User already signed in: $googleUser");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomeScreen(),
          ),
        );
      } else {
        // No user signed in, initiate Google Sign-In
        await handleSignIn(context);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }


  Future<void> handleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signOut(); // Ensure sign-out for clean login

      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await auth.signInWithCredential(credential);
        final user = auth.currentUser;
        print("User: $user");
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomeScreen(),
            ),
          );
        }
      } else {
        print('User is null');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
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
                          _login(context);
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
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          //login();
                         // await _auth.loginWithGoogle();
                         // handleSignIn(context);
                          checkSignInStatus(context);
                        },
                        style: ElevatedButton.styleFrom(
                         // backgroundColor: Colors.indigo.shade400,
                          minimumSize: const Size(400, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.google,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Sign in with Google',
                              style: AppTextStyle.textStyleOne(
                                Colors.black,
                                16,
                                FontWeight.w500,
                              ),

                            ),
                          ],
                        ),
                      ),
                    ),
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
