// ignore_for_file: use_super_parameters, avoid_print, prefer_const_constructors, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({Key? key}) : super(key: key);

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> board = [];
  String? currentPlayer;
  int draw = 0;
  int player1win = 0;
  int player2win = 0;
  int player1Loose = 0;
  int player2Loose = 0;
  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    board = List.generate(3, (_) => List.filled(3, ''));
    currentPlayer = 'X';
  }

  void Tapped(int row, int col) {
    if (board[row][col].isEmpty) {
      setState(() {
        board[row][col] = currentPlayer!;
        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
      });

      String winner = checkForWinner();
      if (winner.isNotEmpty) {
        showWinnerDialog(winner);
      }
    }
  }

  String checkForWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0].isNotEmpty) {
        return board[i][0];
      }
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i].isNotEmpty) {
        return board[0][i];
      }
    }
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0].isNotEmpty) {
      return board[0][0];
    }
    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2].isNotEmpty) {
      return board[0][2];
    }

    bool isDraw = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          isDraw = false;
          break;
        }
      }
    }
    if (isDraw) {
      draw++;
      return 'Draw';
    }

    return '';
  }

  void showWinnerDialog(String winner) {
    if(winner=='x')
    {
      player1win++;
      player2Loose++;
    }
    else{
      player2win++;
      player1Loose++;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content:
            Text(winner == 'Draw' ? 'It\'s a draw!' : 'Player $winner wins!'),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.pop(context);
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    print("Game reset");
    setState(() {
      initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.amber[100],
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: 100),
        // Text("Current: ${currentPlayer}", style: TextStyle(fontSize: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Player 1", style: TextStyle(fontSize: 30)),
            Text("Player 2", style: TextStyle(fontSize: 30))
          ],
        ),
       
        SizedBox(
          height: 50,
        ),
        Container(
            height: 300,
            width: 300,
            color: Colors.black,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              padding: const EdgeInsets.all(1),
              itemCount: 9,
              itemBuilder: (context, index) {
                final row = index ~/ 3;
                final col = index % 3;
                return Padding(
                  padding: const EdgeInsets.all(1),
                  child: GestureDetector(
                    onTap: () => Tapped(row, col),
                    child: Container(
                      color: const Color.fromARGB(255, 223, 223, 223),
                      child: Center(
                        child: Text(
                          board[row][col],
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
        SizedBox(height: 80),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
            onPressed: resetGame,
            child: Text(
              "Reset Game",
              style: TextStyle(fontSize: 17, color: Colors.white),
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8,20,0,0),
                          child: Column(
                            children: [
                              Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width:100),
                                  Text("wins"),
                                  Text("Losses"),
                                  Text("Draw")
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Player 1",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                      "$player1win", style: TextStyle(fontSize: 20)
                                  ),
                                  Text(
                                    "$player1Loose", style: TextStyle(fontSize: 20)
                                  ),
                                  Text(
                                    "$draw", style: TextStyle(fontSize: 20)
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Player 2",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                      "$player2win", style: TextStyle(fontSize: 20)
                                  ),
                                  Text(
                                    "$player2Loose", style: TextStyle(fontSize: 20)
                                  ),
                                  Text(
                                    "$draw", style: TextStyle(fontSize: 20)
                                  )
                                ],
                              ),
                            ],
                          ),
                        ));
                  });
            },
            child: Text(
              "ScoreCard",
              style: TextStyle(fontSize: 17, color: Colors.white),
            ))
      ]),
    ));
  }
}
