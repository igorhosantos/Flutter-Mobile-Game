import 'package:flame/components.dart';
import 'package:mobilegame/view/screens/gameplay.dart';

class StarComponent extends SpriteAnimationComponent
 with HasGameRef<Gameplay> {
  static const speed = 10;

  StarComponent({super.animation, super.position})
    : super(size: Vector2.all(20));

  @override
  void update(double dt) {
    if(gameRef.isPaused)
    {
      return;
    }    
    super.update(dt);
    y += dt * speed;
    if (y >= gameRef.size.y) {
      removeFromParent();
    }
  }
}
