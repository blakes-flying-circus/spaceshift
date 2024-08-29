import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:spaceshift/enemy.dart';
import 'package:spaceshift/main_menu/main_menu_screen.dart';
import 'package:spaceshift/player.dart';
import 'package:flame/experimental.dart';
import 'package:spaceshift/hud.dart';

class SpaceShiftGame extends FlameGame with PanDetector, HasCollisionDetection {
  late Player player;

  int score = 0;
  int lives = 3;

  @override
  Future<void> onLoad() async {
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('stars_0.png'),
        ParallaxImageData('stars_1.png'),
        ParallaxImageData('stars_2.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5),
    );

    camera.viewport.add(Hud(position: Vector2(0, 30)));
    add(parallax);

    player = Player();
    add(player);

    add(
      SpawnComponent(
        factory: (index) {
          return Enemy();
        },
        period: 1,
        area: Rectangle.fromLTWH(
          0,
          0,
          size.x,
          -Enemy.enemySize,
        ),
      ),
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }
}

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => const MainMenuScreen(),
      '/game': (context) => GameWidget(game: SpaceShiftGame()),
    },
  ));
}
