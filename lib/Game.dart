import 'dart:async';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int attempts = 0;
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool oTurn = true;
  bool winnerFound = false;

  Timer? timer;
  static const maxSeconds = 30;
  int Seconds = maxSeconds;
  List<int> matchedIndexes = [];
  List<String> displayXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (Seconds > 0) {
          Seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    Seconds = maxSeconds;
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Color.fromARGB(163, 17, 67, 143),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Player O',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        oScore.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Column(
                    children: [
                      Text(
                        'Player X',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        xScore.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: GridView.builder(
                  //es ko listview se wrap krt hai
                  shrinkWrap: true,
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: Color.fromARGB(255, 10, 37,
                                78), //ye border ka color hai me ne esy b blue hi rakha hai
                          ),
                          color: matchedIndexes.contains(index)
                              ? Colors.amber
                              : Colors.blue,
                        ),
                        child: Center(
                          child: Text(
                            displayXO[index], //
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w900,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    resultDeclaration,
                    style: TextStyle(color: Colors.white, fontSize: 27),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildTimer(),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    _resetScores();
                  },
                  style:ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6 )
                  ),
                  child: Text(
                    'Reset Scores',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            )
            // Timer Widget (Example: Text Widget)
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning;
    if (timer == null) {
      isRunning = false;
    } else {
      isRunning = timer!.isActive;
    }

    if (isRunning) {
      if (!winnerFound && displayXO[index] == '') {
        setState(() {
          if (oTurn && displayXO[index] == '') {
            displayXO[index] = 'O';
            filledBoxes++;
          } else if (!oTurn && displayXO[index] == '') {
            displayXO[index] = 'X';
            filledBoxes++;
          }
          oTurn =
              !oTurn; //Pehli baar ye condition true agli baar k liye ye condition false ho chuki ho gi phir agli baar phir true
          _checkWinner();
        });
      }
    }
  }

  void _checkWinner() {
    // Checking for the 1st Row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }

    // Checking for the 2nd Row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[3] + ' Wins!';
        matchedIndexes.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(displayXO[3]);
      });
    }

    // Checking for the 3rd Row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    // Checking for the 1st Column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    // Checking for the 2nd Column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[1] + ' Wins!';
        matchedIndexes.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayXO[1]);
      });
    }
    // Checking for the 3rd Column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[2] + ' Wins!';
        matchedIndexes.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayXO[2]);
      });
    }

    // Checking for the Diagonal 1
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }

    // Checking for the Diagonal 2
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6, 4, 2]);
        stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    if (!winnerFound) {
      if (!winnerFound && filledBoxes == 9) {
        setState(() {
          resultDeclaration = 'NoBody Wins';
        });
      }
    }
  }

  void _updateScore(String Winner) {
    if (!winnerFound) {
      if (Winner == 'O') {
        oScore++;
      } else if (Winner == 'X') {
        xScore++;
      }
      winnerFound = true;
    }
  }

void _resetScores() {
  setState(() {
    oScore = 0;
    xScore = 0;
  });
  _clearBoard(); // Clear the game board
  stopTimer();   // Stop the timer
}

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] =
            ''; //es ka matlab hai k 9 martaba chalna ta k saryy boxes empty ho jaye
      }
      resultDeclaration =
          ''; //es ka matlab k result declaration me kuch ni likhna
      winnerFound = false;
    });
    filledBoxes = 0;
    matchedIndexes.clear();
  }

  Widget _buildTimer() {
    final isRunning;
    if (timer == null) {
      isRunning = false;
    } else {
      isRunning = timer!.isActive;
    }

    if (isRunning) {
      return SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - Seconds / maxSeconds,
              valueColor: AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 8,
              backgroundColor: Colors.blue,
            ),
            Center(
              child: Text(
                '$Seconds',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
    } else {
      String buttonText;
      if (attempts == 0) {
        buttonText = 'Start';
      } else {
        buttonText = 'PlayAgain';
      }
      return ElevatedButton(
        onPressed: () {
          startTimer();
          _clearBoard();
          attempts++;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      );
    }
  }
}
