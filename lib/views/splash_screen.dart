import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      return const SafeArea(
          child: Scaffold(
        body: Text('Splash'),
      ));
    });
  }
}
