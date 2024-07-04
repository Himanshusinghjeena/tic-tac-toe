// ignore_for_file: use_super_parameters, avoid_print, prefer_const_constructors, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unrelated_type_equality_checks

import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({Key? key}) : super(key: key);

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  bool oTurn = true;
  String winner = '';
  tap(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        oTurn = false;
        winner =CheckWinner();
        if(winner!='')
        {
          print('winner is $winner');
        }
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        oTurn = true;
        winner =CheckWinner();
        if(winner!='')
        {
          print('winner is $winner');
          }
      }
    });
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
    else {
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.amber[100],
      child: Center(
          child: Container(
              height: 300,
              width: 300,
              color: Colors.grey,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                padding: const EdgeInsets.all(1),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(1),
                    child: GestureDetector(
                      onTap: () => tap(index),
                      child: Container(
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            displayElement[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 35),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ))),
    ));
  }
}
