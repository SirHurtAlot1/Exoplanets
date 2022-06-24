import 'dart:math';
import 'dart:ui';

import 'package:exoplanets/Game/classes/Bullet.dart';
import 'package:exoplanets/Game/classes/Player.dart';
import 'package:exoplanets/Game/classes/SpacescapeGame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Enemy extends SpriteComponent with HasGameRef<SpacescapeGame>, CollisionCallbacks{

  double speed = 350;
  double rotationSpeed = 5;
  Random random = Random();
  late Timer timer;



  Enemy({
    Sprite? sprite,
    Vector2? position,
    Vector2? size
  }): super(sprite: sprite, position: position, size: size);





  Vector2 getRandomVector() {
    return (Vector2.random(random) - Vector2(0.5, -1)) * 200;
  }




  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Bullet || other is Player){
      removeFromParent();
      gameRef.player.score++;
    }
    super.onCollision(intersectionPoints, other);
  }



  @override
  void onMount() {
    super.onMount();
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    this.position += Vector2(0, 1)*speed*dt;
    this.angle +=rotationSpeed*dt;
    if(this.position.y > gameRef.size.y)
    {
      removeFromParent();
    }

  }
}