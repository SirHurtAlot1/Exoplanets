import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exoplanets/Game/views/overlays/GameOverMenu.dart';
import 'package:exoplanets/Game/views/overlays/PauseButton.dart';
import 'package:exoplanets/Game/views/overlays/PauseMenu.dart';
import 'package:exoplanets/Game/views/overlays/PlanetOpenedMenu.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../classes/SpacescapeGame.dart';

class SpacescapePage extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> planets;
  final int index;
  SpacescapePage(this.planets, this.index);
  @override
  State<SpacescapePage> createState() => _SpacescapePageState();
}

class _SpacescapePageState extends State<SpacescapePage> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Flame.device.fullScreen();
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GameWidget(
        game: SpacescapeGame(widget.planets, widget.index),
        initialActiveOverlays: [PauseButton.ID],
        overlayBuilderMap: {
          PauseButton.ID: (BuildContext context, SpacescapeGame gameRef) =>
              PauseButton(
                gameRef: gameRef,
              ),
          PauseMenu.ID: (BuildContext context, SpacescapeGame gameRef) =>
              PauseMenu(
                gameRef: gameRef,
              ),
          GameOverMenu.ID: (BuildContext context, SpacescapeGame gameRef) =>
              GameOverMenu(
                gameRef: gameRef,
              ),
          PlanetOpenedMenu.ID: (BuildContext context, SpacescapeGame gameRef) =>
              PlanetOpenedMenu(
                gameRef: gameRef, planets: widget.planets, index: widget.index,

              ),
        },
      ),
    ));
  }
}
