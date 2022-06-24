import 'dart:math';

import 'package:exoplanets/Game/classes/Enemy.dart';
import 'package:exoplanets/Game/classes/SpacescapeGame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';

class EnemyManager extends Component with HasGameRef<SpacescapeGame>{
  late Timer timer;
  SpriteSheet spriteSheet;
  Random random = Random();

  EnemyManager({required this.spriteSheet}):super(){
    timer = Timer(
        0.5,
        onTick: spawnEnemy,
        repeat: true,
        autoStart: false);
  }

  void reset(){
    timer.stop();
    timer.start();
  }


  void spawnEnemy(){
    Vector2 initialSize = Vector2(64, 64);
    Vector2 position = Vector2(random.nextDouble()*gameRef.size.x, 0);
    position.clamp(Vector2.zero() + initialSize/2, gameRef.size-initialSize/2);
    Enemy enemy = Enemy(
        sprite: spriteSheet.getSpriteById(32),
        size: initialSize,
        position: position
    );
    enemy.anchor = Anchor.center;
    gameRef.add(enemy);
  }

  @override
  void onMount() {
    timer.start();
  }

  @override
  void update(double dt) {
    timer.update(dt);
  }
  @override
  void onRemove() {
    timer.stop();
  }

}