import 'dart:math';
import 'package:exoplanets/Game/classes/Bullet.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../classes/SpacescapeGame.dart';

class BulletManager extends Component with HasGameRef<SpacescapeGame> {
  late Timer timer;
  SpriteSheet spriteSheet;
  Random random = Random();
  BulletManager({required this.spriteSheet}) :super() {
    timer = Timer(
        1.1,
        onTick: spawnBullet,
        repeat: true,
        autoStart: false);
  }
  void spawnBullet(){
    Bullet bullet = Bullet(
        sprite: spriteSheet.getSpriteById(28),
        size: Vector2(64, 64),
        position: this.gameRef.player.position.clone());
    bullet.anchor = Anchor.center;
    gameRef.add(bullet);
  }
  @override
  void onMount() {
    timer.start();
  }
  void reset(){
    timer.stop();
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