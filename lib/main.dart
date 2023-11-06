// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PomodoroApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PomodoroApp extends StatefulWidget {
  const PomodoroApp({super.key});

  @override
  State<PomodoroApp> createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State<PomodoroApp> {
  // 3.	Create a  variable of duration = 25 minutes to start the countdown.
  Duration duration = Duration(seconds: 0, minutes: 25);
  // 5.	Use  Global Variables Timer named repFun to call everywhere in the class.
  Timer? repFun;
  // 6.	Create bool named isRuning to use him in the button .
  bool isRunning = false;

  // 4.	Create a function to calculate the time  periodic  inside main app class (class _PomodoroAppState)
  startTimer() {
    repFun = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int newSeconds = duration.inSeconds - 1;
        duration = Duration(seconds: newSeconds);
        if (duration.inSeconds == 0) {
          // use this
          // repFun!.cancel();
          // or this
          timer.cancel();
          setState(() {
            duration = Duration(seconds: 0, minutes: 25);
            isRunning = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 40, 43),
      appBar: AppBar(
        title: Text(
          "Pomodoro App",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 50, 65, 71),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // CircularPercentIndicator contain text or timer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  center: Text(
                    "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                    style: TextStyle(color: Colors.white, fontSize: 80),
                  ),
                  radius: 120.0,
                  progressColor: Color.fromARGB(255, 197, 25, 97),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  lineWidth: 7,
                  // to animate the radus with countdown
                  percent: duration.inMinutes / 25,
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 1000,
                ),
              ],
            ),
            SizedBox(
              height: 55,
            ),

// To show and hide buttons we used bool isRuning  before second row and IF Conditional Statement between the second row
            isRunning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
// 9.	In Stop button we create another button named Resume we have used bool isRunning  to show  the 2  button.

                      ElevatedButton(
// 10.	And in the onPressed we used  if Conditional Statement  to cancel or stop when you click on stop or resume
                        onPressed: () {
                          if (repFun!.isActive) {
                            setState(() {
                              repFun!.cancel();
                            });
                          } else {
                            startTimer();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 197, 25, 97)),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(14)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9))),
                        ),
                        child: Text(
                          (repFun!.isActive) ? "STOP" : "RESUME",
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                      SizedBox(
                        width: 22,
                      ),

                      // 8.	In Cancel button use repFun.cancel , isRunning = false , Duration = 25
                      ElevatedButton(
                        onPressed: () {
                          repFun!.cancel();
                          setState(() {
                            duration = Duration(minutes: 25, seconds: 0);
                            isRunning = false;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 197, 25, 97)),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(14)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9))),
                        ),
                        child: Text(
                          "CANCEL",
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                    ],
                  )

                // 7.	In Start button call function startTimer and use bool isRunning as True
                : ElevatedButton(
                    onPressed: () {
                      startTimer();
                      setState(() {
                        isRunning = true;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 25, 120, 197)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9))),
                    ),
                    child: Text(
                      "START STUDYING",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
          ]),
    );
  }
}
