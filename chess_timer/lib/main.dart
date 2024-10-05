import "package:flutter/material.dart";
import 'package:chess_timer/Screen/Splash_screen.dart';

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: SplashScreen(),
      ),
    ),
  ));
}