import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacking_game/button.dart';
import 'package:stacking_game/pixel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int numOfSquares = 160;
  List<int> piece = [];
  List<int> landed = [10000];
  var direction = "left";
  int level = 0;
  void startGame() {
    piece = [
      numOfSquares - 1 - level * 10,
      numOfSquares - 2 - level * 10,
      numOfSquares - 3 - level * 10
    ];
    Timer.periodic(Duration(milliseconds: 250), (timer) {
      if (checkWinner()) {
        _showWinner();
        timer.cancel();
      }
      if (piece.first % 10 == 0) {
        direction = "right";
      } else if (piece.last % 10 == 9) {
        direction = "left";
      }
      setState(() {
        if (direction == "right") {
          for (int i = 0; i < piece.length; i++) {
            piece[i] -= 1;
          }
        } else {
          for (int i = 0; i < piece.length; i++) {
            piece[i] -= 1;
          }
        }
      });
    });
  }

  bool checkWinner() {
    if (landed.last < 10) {
      return true;
    } else {
      return false;
    }
  }

  void _showWinner() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Winner!"),
          );
        });
  }

  void stack() {
    setState(() {
      level++;
      for (int i = 0; i < piece.length; i++) {
        landed.add(piece[i]);
      }
      if (level < 4) {
        piece = [
          numOfSquares - 3 - level * 10,
          numOfSquares - 2 - level * 10,
          numOfSquares - 1 - level * 10
        ];
      } else if (level >= 4 && level < 8) {
        piece = [numOfSquares - 2 - level * 10, numOfSquares - 1 - level * 10];
      } else if (level >= 8) {
        piece = [numOfSquares - 1 - level * 10];
      }
      checkStack();
    });
  }

  void checkStack() {
    setState(() {
      for (int i = 0; i < landed.length; i++) {
        if (!landed.contains(landed[i] + 10) &&
            (landed[i] + 10) < numOfSquares - 1) {
          landed.remove(landed[i]);
        }
      }
      for (int i = 0; i < landed.length; i++) {
        if (!landed.contains(landed[i] + 10) &&
            (landed[i] + 10) < numOfSquares - 1) {
          landed.remove(landed[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: GridView.builder(
                itemCount: numOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10),
                itemBuilder: (BuildContext context, int i) {
                  if (piece.contains(i)) {
                    return MyPixel(
                      color: Colors.white,
                    );
                  } else if (landed.contains(i)) {
                    return MyPixel(
                      color: Colors.white,
                    );
                  } else {
                    return MyPixel(
                      color: Colors.black,
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyButton(
                      function: startGame,
                      text: Text(
                        "P L A Y",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    MyButton(
                      function: stack,
                      text: Text(
                        "S T O P",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
