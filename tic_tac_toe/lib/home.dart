// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/tictac.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color bgcolor = const Color(0XFF11213A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        "https://media.istockphoto.com/id/1292919739/vector/tic-tac-toe-school-game-colorful-seamless-pattern-for-fabric-and-print-on-the-paper.jpg?s=612x612&w=0&k=20&c=Q4gMspKHffPmhKuofb_Rb_WCD8uAgbsbXSKuWEcziM8=",
                      ),
                      fit: BoxFit.fill))),
          Positioned(
              top: 300,
              left: 40,
              child: Container(
                color: bgcolor,
                child: const Text("TIC TAC TOE",
                    style: TextStyle(color: Colors.white, fontSize: 50)),
              )),
          Positioned(
            bottom: 220,
            left: 120,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TicTacToeGame()));
                },
                child: const Text("Play Game", style: TextStyle(fontSize: 18))),
          )
        ]));
  }
}
