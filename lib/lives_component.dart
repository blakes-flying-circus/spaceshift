import 'package:flame/components.dart';
import 'package:spaceshift/main.dart';

enum LivesState {
  available,
  unavailable,
}

class LivesComponent extends SpriteGroupComponent<LivesState>
    with HasGameReference<SpaceShiftGame> {
  final int livesNumber;

  LivesComponent({
    required this.livesNumber,
    required super.position,
    required super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final availableSprite = await game.loadSprite(
      'heart.png',
      srcSize: Vector2.all(32),
    );

    final unavailableSprite = await game.loadSprite(
      'heart_half.png',
      srcSize: Vector2.all(32),
    );

    sprites = {
      LivesState.available: availableSprite,
      LivesState.unavailable: unavailableSprite,
    };

    current = LivesState.available;
  }

  @override
  void update(double dt) {
    if (game.lives < livesNumber) {
      current = LivesState.unavailable;
    } else {
      current = LivesState.available;
    }
    super.update(dt);
  }
}
