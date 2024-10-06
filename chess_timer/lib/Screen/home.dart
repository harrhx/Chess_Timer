import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chess_timer/Screen/timerscreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedValue = 'Fischer'; // Default selected value
  final List<String> items = ['Fischer', 'Bronstein'];
  bool diffplayer = false;
  bool haptics = true;
  int player1min = 10;
  int player1sec = 5;
  int player2min = 10;
  int player2sec = 5;
  List<String> info = [
    "Fischer Timing Method : Extra Seconds is added after each move",
    "After a player makes a move, they are granted a time increment. However, if the player made their move within the increment time, only the actual time spent on the move is added in the clock"
  ];

  @override
  void initState() {
    super.initState();
  }

  // Initialize controllers without 'late' keyword
  final TextEditingController _player1mincontroller =
      TextEditingController(text: "10");
  final TextEditingController _player1secondcontroller =
      TextEditingController(text: "5");
  final TextEditingController _player2mincontroller =
      TextEditingController(text: "10");
  final TextEditingController _player2secondscontroller =
      TextEditingController(text: "5");

  @override
  void dispose() {
    _player1mincontroller.dispose();
    _player1secondcontroller.dispose();
    _player2mincontroller.dispose();
    _player2secondscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/bglogo.png"), opacity: 0.2),
                ),
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'CHESS TIMER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'seymourOne',
                        fontWeight: FontWeight.w900,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 24),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 260,
                        height: 60,
                        child: Opacity(
                          opacity: 0.80,
                          child: Text(
                            'Time different between Players',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Roboto Condensed',
                              fontWeight: FontWeight.w900,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Switch(
                          value: diffplayer,
                          onChanged: (value) {
                            setState(() {
                              diffplayer = !diffplayer;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Opacity(
                                    opacity: 0.80,
                                    child: Text(
                                      'Minutes',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Roboto Condensed',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Opacity(
                                    opacity: 0.80,
                                    child: Text(
                                      'Extra Seconds',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Roboto Condensed',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Opacity(
                                    opacity: 0.80,
                                    child: Text(
                                      'Player 1',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Roboto Condensed',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Opacity(
                                    opacity: 0.80,
                                    child: Text(
                                      'Player 2',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Roboto Condensed',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _player1mincontroller,
                                        keyboardType: TextInputType.number,
                                        onChanged: (String value) {
                                          setState(() {
                                            player1min =
                                                int.tryParse(value) ?? 10;
                                          });
                                        },
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Roboto Condensed',
                                          fontWeight: FontWeight.w900,
                                          height: 0,
                                        ),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            bottom: -20,
                                          ), // Adjust the vertical padding
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Expanded(
                                      child: Opacity(
                                        opacity: (diffplayer) ? 1.0 : 0.1,
                                        child: TextField(
                                          enabled: diffplayer,
                                          controller: _player2mincontroller,
                                          keyboardType: TextInputType.number,
                                          onChanged: (String value) {
                                            setState(() {
                                              player2min =
                                                  int.tryParse(value) ?? 10;
                                            });
                                          },
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Roboto Condensed',
                                            fontWeight: FontWeight.w900,
                                            height: 0,
                                          ),
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                              bottom: -20,
                                            ), // Adjust the vertical padding
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            disabledBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _player1secondcontroller,
                                        keyboardType: TextInputType.number,
                                        onChanged: (String value) {
                                          setState(() {
                                            player1sec =
                                                int.tryParse(value) ?? 5;
                                          });
                                        },
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Roboto Condensed',
                                          fontWeight: FontWeight.w900,
                                          height: 0,
                                        ),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            bottom: -20,
                                          ), // Adjust the vertical padding
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Expanded(
                                      child: Opacity(
                                        opacity: (diffplayer) ? 1.0 : 0.1,
                                        child: TextField(
                                          enabled: diffplayer,
                                          controller: _player2secondscontroller,
                                          keyboardType: TextInputType.number,
                                          onChanged: (String value) {
                                            setState(() {
                                              player2sec =
                                                  int.tryParse(value) ?? 5;
                                            });
                                          },
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Roboto Condensed',
                                            fontWeight: FontWeight.w900,
                                            height: 0,
                                          ),
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                              bottom: -20,
                                            ), // Adjust the vertical padding
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            disabledBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 24, right: 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Opacity(
                            opacity: 0.80,
                            child: Text(
                              'Timing Method',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'Roboto Condensed',
                                fontWeight: FontWeight.w900,
                                height: 0,
                              ),
                            ),
                          ),
                          Spacer(),
                          DropdownButton<String>(
                            value: selectedValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            dropdownColor: Color.fromRGBO(60, 60, 60, 0.498),
                            style: GoogleFonts.robotoCondensed(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 5,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors
                                  .blueAccent, // Customize the underline color
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: items
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        child: Text(
                          (selectedValue == 'Fisher') ? info[0] : info[1],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Color(0xFF656363),
                            fontSize: 12,
                            fontFamily: 'Roboto Condensed',
                            fontWeight: FontWeight.w900,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 24, right: 24),
                  child: Row(
                    children: [
                      Opacity(
                        opacity: 0.80,
                        child: Text(
                          'Sound and Haptics',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Roboto Condensed',
                            fontWeight: FontWeight.w900,
                            height: 0,
                          ),
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: haptics,
                        onChanged: (value) {
                          setState(() {
                            haptics = !haptics;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 50, left: 24, right: 24),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Timerscreen(
                                  Timemethod: selectedValue,
                                  player1min: player1min,
                                  player1sec: player1sec,
                                  player2min: (diffplayer) ? player2min : player1min,
                                  player2sec: (diffplayer) ? player2sec : player1sec,
                                  haptic: haptics,
                                  diff: diffplayer,
                                  
                              )),
                        );
                      },
                      child: Container(
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'START',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Roboto Condensed',
                              fontWeight: FontWeight.w900,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
