// ignore_for_file: use_super_parameters, avoid_print, prefer_const_constructors, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unrelated_type_equality_checks

import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({Key? key}) : super(key: key);

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  int winnerX = 0;
  int winnerO = 0;
  int Draw = 0;
  bool gameover = false;
  Color bgcolor = Color(0XFF11213A);
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  bool oTurn = true;
  int isTapped = -1;
  String winner = '';
  String currentPlayer = 'O';

  init() {
    displayElement = ['', '', '', '', '', '', '', '', ''];
    oTurn = true;
    isTapped = -1;
    winner = '';
    currentPlayer = "O";
    gameover = false;
  }

  tap(int index) {
    if (!gameover) {
      setState(() {
        if (oTurn && displayElement[index] == '') {
          displayElement[index] = 'O';
          oTurn = false;
          isTapped = index;
          currentPlayer = 'ㄨ';
          checkWinner();
        } else if (!oTurn && displayElement[index] == '') {
          displayElement[index] = 'ㄨ';
          oTurn = true;
          isTapped = index;
          currentPlayer = 'O';
          checkWinner();
        }
      });
    }
  }

  checkWinner() {
    winner = CheckWinner();
    if (winner == "ㄨ") {
      winnerX++;
      setState(() {
        gameover = true;
      });
      showDailogBox();
      print("WinnerX: $winnerX");
      print("WinnerO: $winnerO");
    } else if (winner == "O") {
      winnerO++;
      setState(() {
        gameover = true;
      });
      showDailogBox();
      print("WinnerX: $winnerX");
      print("WinnerO: $winnerO");
    } else if (winner == "Draw") {
      Draw++;
      showDailogBox();
    }
  }

  showDailogBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(winner != "Draw" ? "Congratulations" : 'Game Over'),
              content: Text(winner == 'Draw'
                  ? 'The game is draw'
                  : winner == "ㄨ"
                      ? "Player2 Wins !"
                      : "Player1 Wins !"),
              actions: [
                ElevatedButton(
                  child: Text('Play Again'),
                  onPressed: () {
                    setState(() {
                      init();
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  String CheckWinner() {
    // Horizontal
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement != '') {
      return displayElement[0];
    } else if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      return displayElement[3];
    } else if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      return displayElement[6];
    }

    // Vertical
    else if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      return displayElement[0];
    } else if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      return displayElement[1];
    } else if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      return displayElement[2];
    }
    // Diagonal
    else if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      return displayElement[0];
    } else if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      return displayElement[2];
    }
    bool isDraw = true;
    for (var element in displayElement) {
      if (element == '') {
        isDraw = false;
        break;
      }
    }
    if (isDraw) {
      return 'Draw';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:
                  Icon(color: Colors.white, Icons.arrow_back_ios_new_outlined)),
          title:
              Text("Welcome to My Game", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: bgcolor,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                child: Container(
                    height: 50,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Player1: $winnerO",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        Text("player2: $winnerX",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        Text("Draw: $Draw",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400))
                      ],
                    )),
              ),
              Text("Current Player: ${currentPlayer}",
                  style: TextStyle(color: Colors.white, fontSize: 30)),
              SizedBox(height: 30),
              Container(
                  height: 280,
                  width: 280,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => tap(index),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Container(
                            decoration: BoxDecoration(
                                color: isTapped == index
                                    ? Color(0xeaffffff)
                                    : Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: Text(
                                displayElement[index],
                                style: TextStyle(
                                    color: displayElement[index] == "ㄨ"
                                        ? Color(0xff05ab9b)
                                        : Color(0xff9d9b15),
                                    fontSize: 45),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ]),
          ),
          Positioned(
              bottom: 50,
              right: 50,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      winnerX = 0;
                      winnerO = 0;
                      Draw = 0;
                      init();
                    });
                  },
                  child: Text("Reset Game",
                      style: TextStyle(color: Colors.black, fontSize: 18))))
        ]));
  }
}
