import 'dart:async';
import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double iniHeight = birdYAxis;
  bool gameStart = false;
  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.3;
  int currscore = 0;
  int highscore = 0;
  double startx = 0;

  void jump() {
    setState(() {
      time = 0;
      iniHeight = birdYAxis;
    });
  }

  bool collision() {
    if (birdYAxis < -1 || birdYAxis > 1) {
      return true;
    }
    double screenWidth = (MediaQuery.of(context).size.width) / 2;
    startx = ((40) / screenWidth);
    double screenheight = (MediaQuery.of(context).size.height) * 0.75 / 2;
    double hdown1 =
        (screenheight - (200 + 40 - 0.1 * screenheight)) / screenheight;
    double hup1 =
        (screenheight - (150 + 40 - 0.1 * screenheight)) / screenheight;
    double hdown2 =
        (screenheight - (150 + 40 - 0.1 * screenheight)) / screenheight;
    double hup2 =
        (screenheight - (200 + 40 - 0.1 * screenheight)) / screenheight;

    if ((barrierXOne < startx && barrierXOne > -startx) &&
        (birdYAxis > hdown1 || birdYAxis < -hup1)) {
      return true;
    }
    if ((barrierXTwo < startx && barrierXTwo > -startx) &&
        (birdYAxis > hdown2 || birdYAxis < -hup2)) {
      return true;
    }

    return false;
  }

  void startGame() {
    gameStart = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = -4 * time * time + 2 * time;
      time += 0.05;
      setState(() {
        birdYAxis = iniHeight - height;
      });
      if ((barrierXOne < 0 && barrierXOne > -0.05) || (barrierXTwo < 0 && barrierXTwo > -0.05)) {
        setState(() {
          currscore += 1;
          highscore = max(highscore, currscore);
        });
      }
      setState(() {
        if (barrierXOne < -1.3) {
          barrierXOne = barrierXTwo + 1.3;
        } else {
          barrierXOne -= 0.05;
        }
      });
      setState(() {
        if (barrierXTwo < -1.3) {
          barrierXTwo = barrierXOne + 1.3;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (collision()) {
        timer.cancel();
        gameOver();
        gameStart = false;
      }
    });
  }

  void gameOver() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('GAME OVER'),
          content: Text('SCORE = $currscore'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                resetGame();
              },
              child: const Text('Play Again'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                SystemNavigator.pop(); 
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      birdYAxis = 0;
      time = 0;
      height = 0;
      iniHeight = birdYAxis;
      barrierXOne = 1;
      barrierXTwo = barrierXOne + 1.3;
      gameStart = false;
      currscore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameStart) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: const MyBird(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.2),
                    child: gameStart
                        ? const Text(' ')
                        : const Text(
                            'TAP TO PLAY',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 250.0,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Score',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '$currscore',
                          style: const TextStyle(color: Colors.white, fontSize: 35),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Top Score',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '$highscore',
                          style: const TextStyle(color: Colors.white, fontSize: 35),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
