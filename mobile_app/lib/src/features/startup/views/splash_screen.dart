import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app/src/constant/lotttie_animation.dart';
import 'package:mobile_app/src/features/startup/views/welcome_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
           // color: Colors.grey,
            child: Lottie.asset(
              LottieAnimations.splash_1,
              width: 220,
              height: 220,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
