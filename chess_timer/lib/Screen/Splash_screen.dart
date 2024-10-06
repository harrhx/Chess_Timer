import 'package:flutter/material.dart';
import 'package:chess_timer/Screen/home.dart';
import 'dart:async'; // For Future.delayed

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0; // Initial opacity set to 1 (fully visible)

  @override
  void initState() {
    super.initState();

    // Start fading after 3 seconds
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 0.0; // Change opacity to 0 (fade out)
      });
    });

    // Wait for 5 seconds and navigate with slide transition to HomeScreen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide from right to center
            const begin = Offset(1.0, 0.0);
            const end = Offset(0.0, 0.0);
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnimatedOpacity(
        opacity: 1,
        duration: Duration(seconds: 2), // Fades out over 2 seconds
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Center(
            child: Image.asset("assets/bglogo.png"),
          ),
        ),
      ),
    );
  }
}

