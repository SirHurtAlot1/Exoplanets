import 'package:exoplanets/Game/classes/Enemy.dart';
import 'package:exoplanets/Game/classes/SpacescapeGame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
class Bullet extends SpriteComponent with HasGameRef<SpacescapeGame>,CollisionCallbacks{
  double speed = 450;
  Bullet({
    Sprite? sprite,
    Vector2? position,
    Vector2? size
  }): super(sprite: sprite, position: position, size: size);
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(
        position: Vector2(size.x/2,size.y/2),
        anchor: Anchor.center,
        size: Vector2(20,20)));
  }
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is Enemy){
      removeFromParent();
    }
  }
  @override
  void update(double dt) {
    this.position += Vector2(0, -1)*speed*dt;
    if(this.position.y < 0)
    {
      removeFromParent();
    }
  }
}