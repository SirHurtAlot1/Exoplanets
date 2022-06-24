import 'dart:math';

import 'package:exoplanets/Game/classes/Enemy.dart';
import 'package:exoplanets/Game/classes/SpacescapeGame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class Player extends SpriteComponent
    with HasGameRef<SpacescapeGame>, CollisionCallbacks {
  Vector2 moveDirection = Vector2.zero();
  double speed = 300;
  Random random = Random();
  int score = 0;
  int hitPoints = 100;

  Player({Sprite? sprite, Vector2? position, Vector2? size})
      : super(sprite: sprite, position: position, size: size);

  Vector2 getRandomVector() {
    return (Vector2.random(random) - Vector2(0.5, -1)) * 200;
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.position += moveDirection.normalized() * speed * dt;
    this
        .position
        .clamp(Vector2.zero() + this.size / 2, gameRef.size - this.size / 2);

    final particleComponent = ParticleSystemComponent(
        particle: AcceleratedParticle(
            lifespan: 0.4,
            acceleration: getRandomVector() * 2,
            speed: getRandomVector(),
            position: (this.position.clone() + Vector2(0, this.size.y / 3)),
            child: CircleParticle(
              radius: 3,
              paint: Paint()
                ..color = Color.lerp(
                    Colors.redAccent, Colors.orange, random.nextDouble())!,
            )));
    gameRef.add(particleComponent);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      gameRef.camera.shake(duration: 0.5, intensity: 25);
      if (hitPoints > 0) {
        hitPoints -= 10;
      }
    }
  }
  void reset(){
    score = 0;
    hitPoints = 100;
    this.position = gameRef.size / 2;
  }

  @override
  void onMount() {
    super.onMount();

    add(CircleHitbox());
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    moveDirection = newMoveDirection;
  }
}
