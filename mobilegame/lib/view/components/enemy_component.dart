import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mobilegame/view/components/explosion_component.dart';
import 'package:mobilegame/view/screens/gameplay.dart';

class EnemyComponent extends SpriteAnimationComponent
    with HasGameRef<Gameplay>, CollisionCallbacks {
  static const speed = 150;
  static final Vector2 initialSize = Vector2.all(25);

  EnemyComponent({required super.position})
    : super(size: initialSize, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'enemy.png',
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 4,
        textureSize: Vector2.all(16),
      ),
    );
    add(CircleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);
    y += speed * dt;
    if (y >= gameRef.size.y) {
      removeFromParent();
    }
  }

  void takeHit() {
    removeFromParent();

    gameRef.explosionGroup.add(ExplosionComponent(position: position));
    gameRef.increaseScore();
  }
}
