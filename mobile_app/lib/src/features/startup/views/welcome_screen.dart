import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app/src/features/authentication/views/login_screen.dart';

import '../../../constant/images.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.welcome1),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                   // color: Colors.grey,
                    margin: const EdgeInsets.only(top: 170),
                    height: 70,
                    width: double.infinity,
                    child: FittedBox(
                      child: Lottie.asset(
                        'lottie-animation/welcome.json',
                        repeat: true,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      HapticFeedback.mediumImpact();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );

                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 440),
                     //  color: Colors.grey,
                      height: 115,
                      width: double.infinity,
                      child: FittedBox(
                        child: Lottie.asset(
                          'lottie-animation/next_button2.json',
                          repeat: true,
                        ),
                      ),
                    ),
                  ),


                  // Container(
                  //   margin: EdgeInsets.only(top: 480),
                  //   padding: EdgeInsets.all(12),
                  //   decoration: BoxDecoration(
                  //     borderRadius:BorderRadius.circular(30),
                  //     color: Colors.greenAccent,
                  //   ),
                  //   child: Icon(Icons.arrow_forward,weight: 14,size: 30,),
                  // ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
