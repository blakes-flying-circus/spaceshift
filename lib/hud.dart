import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spaceshift/lives_component.dart';
import 'package:spaceshift/main.dart';

class Hud extends PositionComponent with HasGameReference<SpaceShiftGame> {
  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });

  late TextComponent _scoreTextComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final textStyle = GoogleFonts.vt323(
      fontSize: 35,
      color: Colors.amber,
    );
    final defaultRenderer = TextPaint(style: textStyle);
    final scoreCountRenderer = TextPaint(
      style: textStyle.copyWith(fontSize: 55, fontWeight: FontWeight.bold),
    );
    print(game.size.x);

    add(
      TextComponent(
        text: 'SCORE',
        position: Vector2(game.size.x - 40, 30),
        textRenderer: defaultRenderer,
        anchor: Anchor.bottomRight,
      ),
    );
    _scoreTextComponent = TextComponent(
      text: game.score.toString(),
      position: Vector2(game.size.x - 40, 80),
      textRenderer: scoreCountRenderer,
      anchor: Anchor.bottomRight,
    );
    add(_scoreTextComponent);

    for (var i = 1; i <= game.lives; i++) {
      final positionX = 40 * i;
      await add(
        LivesComponent(
          livesNumber: i,
          position: Vector2(positionX.toDouble(), 0),
          size: Vector2.all(32),
        ),
      );
    }
  }

  @override
  void update(double dt) {
    _scoreTextComponent.text = game.score.toString();
  }
}
