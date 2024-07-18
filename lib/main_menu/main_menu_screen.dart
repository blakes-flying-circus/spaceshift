import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spaceshift/main.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5b6ee1),
      body: Center(
        child: MaterialButton(
            color: Colors.white,
            child: const Text('Play'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameWidget(game: SpaceShooterGame()),
                ),
              );
            }),
      ),
    );
  }
}
