import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TweenAnimationBuilder(
          duration: const Duration(seconds: 2),
          onEnd: () {
            Get.offAndToNamed("homePage");

          },
          tween: Tween(begin: 0.0, end: 160.0),
          builder: (context, value, child) {
            return Center(
              child: Icon(
                Icons.wallet,
                size: value,
              ),
            );
          }),
    );
  }
}
