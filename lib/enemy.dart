import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:spaceshift/bullet.dart';
import 'package:spaceshift/explosion.dart';
import 'package:spaceshift/main.dart';
import 'package:spaceshift/player.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameReference<SpaceShiftGame>, CollisionCallbacks {
  Enemy({
    super.position,
  }) : super(
          size: Vector2.all(enemySize),
          anchor: Anchor.center,
        );

  static const enemySize = 50.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'enemy.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(16),
      ),
    );
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }

  @override
  Future<void> onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      removeFromParent();
      other.removeFromParent();
      game.add(Explosion(position: position));
      game.score += 10;
    } else if (other is Player) {
      removeFromParent();
      game.add(Explosion(position: position));
      game.lives -= 1;
      if (game.lives == 0) {
        await Future.delayed(const Duration(milliseconds: 500));
        game.pauseEngine();
      }
    }
  }
}
