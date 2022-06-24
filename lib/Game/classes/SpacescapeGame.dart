import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exoplanets/Game/classes/Bullet.dart';
import 'package:exoplanets/Game/classes/Enemy.dart';
import 'package:exoplanets/Game/services/BulletManager.dart';
import 'package:exoplanets/Game/services/EnemyManager.dart';
import 'package:exoplanets/Game/views/overlays/GameOverMenu.dart';
import 'package:exoplanets/Game/views/overlays/PauseButton.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import '../views/overlays/PlanetOpenedMenu.dart';
import 'Player.dart';

class SpacescapeGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  SpacescapeGame(this.planets, this.index);
  final AsyncSnapshot<QuerySnapshot> planets;
  final int index;
  late Player player;
  late SpriteSheet spriteSheet;
  late EnemyManager enemyManager;
  late BulletManager bulletManager;
  Offset? pointerStartPosition;
  Offset? pointerCurrentPosition;
  final mainJoystickRad = 60.0;
  final childJoystickRad = 20.0;
  final joystickDeadZoneRad = 10.0;
  bool isLoaded = false;
  late Timer timer;
  bool isEndgame = false;
  final TextPaint playerScore = TextPaint(
    style: TextStyle(
      fontSize: 24,
    ),
  );
  final TextPaint playerHitPoints = TextPaint(
    style: TextStyle(
      fontSize: 24,
    ),
  );
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if(!isEndgame)
    {
      if (pointerStartPosition != null) {
        canvas.drawCircle(pointerStartPosition!, mainJoystickRad,
            Paint()..color = Colors.deepPurpleAccent.withAlpha(100));
      }
      if (pointerCurrentPosition != null) {
        var delta = pointerCurrentPosition! - pointerStartPosition!;
        if (delta.distance > mainJoystickRad) {
          delta = pointerStartPosition! +
              (Vector2(delta.dx, delta.dy).normalized() * 60).toOffset();
        } else {
          delta = pointerCurrentPosition!;
        }
        canvas.drawCircle(delta, childJoystickRad,
            Paint()..color = Colors.white.withAlpha(100));
      }
      playerScore.render(
          canvas, 'Energy: ' + player.score.toString(), Vector2(10, 10),
          anchor: Anchor.topLeft);
      playerHitPoints.render(
          canvas, 'DB: ' + player.hitPoints.toString(), Vector2(size.x - 10, 10),
          anchor: Anchor.topRight);
    }
  }
  @override
  Future<void> onLoad() async {
    if(!isLoaded){
      await images.load('simpleSpace_tilesheet@2.png');
      ParallaxComponent stars = await ParallaxComponent.load(
          [
            ParallaxImageData('stars1.png'),
            ParallaxImageData('stars2.png')
          ],
        repeat: ImageRepeat.repeat,
        baseVelocity: Vector2(0, -35),
        velocityMultiplierDelta: Vector2(0, 1.3)
      );
      add(stars);
      spriteSheet = SpriteSheet.fromColumnsAndRows(
          image: images.fromCache('simpleSpace_tilesheet@2.png'),
          columns: 8,
          rows: 6);

      player = Player(
          sprite: spriteSheet.getSpriteById(10),
          size: Vector2(64, 64),
          position: size / 2);

      player.anchor = Anchor.center;
      add(player);
      enemyManager = EnemyManager(spriteSheet: spriteSheet);
      add(enemyManager);
      bulletManager = BulletManager(spriteSheet: spriteSheet);
      isLoaded = true;
    }
  }
  @override
  void update(double dt) {
    super.update(dt);
    if(player.hitPoints <= 0){
      this.pauseEngine();
      this.overlays.remove(PauseButton.ID);
      this.overlays.add(GameOverMenu.ID);
    }
    if(player.score >= 5){
      enemyManager.timer.stop();
      bulletManager.timer.stop();
      isEndgame = true;
      player.position -= Vector2(0,-3);
      player.hitPoints = 100;
      this.overlays.remove(PauseButton.ID);
      this.overlays.add(PlanetOpenedMenu.ID);
    }
  }
  void reset(){
    player.reset();
    enemyManager.reset();
    bulletManager.reset();
    children.whereType<Enemy>().forEach((enemy) {enemy.removeFromParent(); });
    children.whereType<Bullet>().forEach((bullet) {bullet.removeFromParent(); });
  }

  void endGame(){
    this.pauseEngine();
    this.overlays.remove(PauseButton.ID);
    this.overlays.add(PlanetOpenedMenu.ID);
  }
  @override
  void onPanStart(DragStartInfo info) {
    if(!isEndgame){
      pointerStartPosition = info.raw.globalPosition;
      pointerCurrentPosition = info.raw.globalPosition;
      if(!this.paused) {
        add(bulletManager);
      }
    }
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    if(!isEndgame){
      pointerCurrentPosition = info.raw.globalPosition;
      var delta = pointerCurrentPosition! - pointerStartPosition!;
      if (delta.distance > joystickDeadZoneRad) {
        player.setMoveDirection(Vector2(delta.dx, delta.dy));
      } else {
        player.setMoveDirection(Vector2.zero());
      }
    }
  }
  @override
  void onPanEnd(DragEndInfo info) {
    if(!isEndgame){
      pointerStartPosition = null;
      pointerCurrentPosition = null;
      player.setMoveDirection(Vector2.zero());
      if(children.contains(bulletManager)){
        remove(bulletManager);
      }
    }
  }
  @override
  void onPanCancel() {
    if(!isEndgame) {
      pointerStartPosition = null;
      pointerCurrentPosition = null;
      player.setMoveDirection(Vector2.zero());
    }
  }
}
