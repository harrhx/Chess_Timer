import 'package:flutter/material.dart';
import 'dart:async'; // Import the async package for Timer
import 'package:flutter/services.dart';

class Timerscreen extends StatefulWidget {
  final String Timemethod; // 'fischer' or 'bronstein'
  final int player1min;
  final int player1sec;
  final int player2min;
  final int player2sec;
  final bool haptic;
  final bool diff;

  Timerscreen({
    required this.Timemethod,
    required this.player1min,
    required this.player1sec,
    required this.player2min,
    required this.diff,
    required this.player2sec,
    required this.haptic, // Increment value for Fischer/Bronstein
  });

  

  @override
  _timerState createState() => _timerState();
}

class _timerState extends State<Timerscreen> {
  late Timer _timer;
  late int player1Time;
  late int player2Time;
  late int lastPlayer1Time; // For Bronstein time tracking
  late int lastPlayer2Time; // For Bronstein time tracking
  int isPlayer1Turn = -1; // Track whose turn it is
  bool isRunning = false;
  int player1moves = 0;
  int player2moves = 0;


  @override
  void initState() {
    super.initState();
    player1Time = widget.player1min * 60;
    player2Time = widget.player2min * 60;
    lastPlayer1Time = player1Time; // Initialize the time for Bronstein method
    lastPlayer2Time = player2Time;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    if (!isRunning) {
      isRunning = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (isPlayer1Turn == 0) {
            if (player1Time > 0) {
              player1Time--;
            } else {
              _timer.cancel();
              isRunning = false;
              // Handle timer end for player 1
            }
          } else if(isPlayer1Turn == 1){
            if (player2Time > 0) {
              player2Time--;
            } else {
              _timer.cancel();
              isRunning = false;
              // Handle timer end for player 2
            }
          }
        });
      });
    }
  }

  void pauseTimer() {
    if (isRunning) {
      _timer.cancel();
      isRunning = false;
    }
  }

  void switchTurns() {
    setState(() {
      if (isPlayer1Turn == 0) {
        // Player 1's turn ends
        player1moves++;
        handleTimeMethod(
          currentTime: player1Time,
          lastTime: lastPlayer1Time,
        );
      } else if (isPlayer1Turn == 1) {
        // Player 2's turn ends
        player2moves++;
        handleTimeMethod(
          currentTime: player2Time,
          lastTime: lastPlayer2Time,
        );
      }

      if(isPlayer1Turn != -1){
        // Switch the turn to the other player
      if(isPlayer1Turn == 0){
        isPlayer1Turn = 1;
      }else{
        isPlayer1Turn = 0;
      }
      // Track the last time for Bronstein method
      lastPlayer1Time = player1Time;
      lastPlayer2Time = player2Time;
      }
    });

    startTimer(); // Start timer for the other player
  }

  // Method to handle Fischer and Bronstein time methods
  // Method to handle Fischer and Bronstein time methods
void handleTimeMethod({required int currentTime, required int lastTime}) {
  if (widget.Timemethod == 'Fischer') {
    // Fischer method: add increment directly
    setState(() {
      if (isPlayer1Turn == 0) {
        player1Time += widget.player1sec; // Increment player 1's time
      } else if(isPlayer1Turn == 1){
        player2Time += widget.player2sec; // Increment player 2's time
      }
    });
  } else if (widget.Timemethod == 'Bronstein') {
    // Bronstein method: add the minimum of the increment or time spent
    int timeSpent = lastTime - currentTime;
    int bonusTime = 0;
    if (isPlayer1Turn == 0) {
      bonusTime = (timeSpent < widget.player1sec) ? timeSpent : widget.player1sec; // Increment for player 1
    } else if (isPlayer1Turn == 1) {
      bonusTime = (timeSpent < widget.player2sec) ? timeSpent : widget.player2sec; // Increment for player 2
    }
    setState(() {
      if (isPlayer1Turn == 0) {
        player1Time += bonusTime; // Add the bonus time for player 1
      } else if (isPlayer1Turn == 1) {
        player2Time += bonusTime; // Add the bonus time for player 2
      }
    });
  }
}


  String formatTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.05,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  (widget.haptic) ? HapticFeedback.lightImpact() : null;
                  if(isPlayer1Turn == -1){
                    isPlayer1Turn = 0;
                    startTimer();
                  }else{
                    if(isPlayer1Turn == 0){
                      switchTurns();
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.4,
                  decoration: ShapeDecoration(
                    color: (isPlayer1Turn == 0) ? Color.fromARGB(255, 18, 156, 34) : Color(0xFF333131) ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          player1moves.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Roboto Condensed',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: 0.9,
                          child: Text(
                            formatTime(player1Time),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.play_arrow, // Play icon
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: startTimer,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.pause, // Pause icon
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: pauseTimer,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.replay, // Restart icon
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      pauseTimer();
                      setState(() {
                        player1Time = widget.player1min * 60;
                        player2Time = widget.player2min * 60;
                        isPlayer1Turn = -1; // Reset to player 1's turn
                        lastPlayer1Time = player1Time;
                        lastPlayer2Time = player2Time;
                        player1moves = 0;
                        player2moves = 0;
                      });
                    },
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  (widget.haptic) ? HapticFeedback.lightImpact() : null;
                  if(isPlayer1Turn == -1){
                    isPlayer1Turn = 1;
                    startTimer();

                  }else{
                    if(isPlayer1Turn == 1){
                      switchTurns();
                      } 
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.4,
                  decoration: ShapeDecoration(
                    color: (isPlayer1Turn == 1) ? Color.fromARGB(255, 18, 156, 34) : Color(0xFF333131),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          player2moves.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Roboto Condensed',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: 0.9,
                          child: Text(
                            formatTime(player2Time),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
