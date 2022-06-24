

import 'package:exoplanets/Game/classes/SpacescapeGame.dart';
import 'package:exoplanets/Game/views/overlays/PauseMenu.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
  static const String ID = 'PauseButton';
  final SpacescapeGame gameRef;
  const PauseButton({required this.gameRef,Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: TextButton(
          onPressed: (){
            gameRef.pauseEngine();
            gameRef.overlays.add(PauseMenu.ID);
            gameRef.overlays.remove(PauseButton.ID);
            },
          child: Icon(
            Icons.pause_rounded,
            size: 30,
            color: Colors.white,
          )
      ),
    );
  }
}
