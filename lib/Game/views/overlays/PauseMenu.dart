import 'package:exoplanets/Game/classes/SpacescapeGame.dart';
import 'package:exoplanets/Game/views/MainMenu.dart';
import 'package:exoplanets/Game/views/overlays/PauseButton.dart';
import 'package:flutter/material.dart';

import '../SpacescapePage.dart';

class PauseMenu extends StatelessWidget {
  static const String ID = 'PauseMenu';
  final SpacescapeGame gameRef;
  const PauseMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(
              'Paused',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 45,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                        blurRadius: 20.0,
                        color: Colors.white,
                        offset: Offset(0, 0))
                  ]),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.resumeEngine();
                  gameRef.overlays.add(PauseButton.ID);
                  gameRef.overlays.remove(PauseMenu.ID);

                },
                child: Text('Resume',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0XFFAEBBDD)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)))),
              )),
          SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove('PauseMenu');
                  gameRef.reset();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MainMenu()));
                },
                child: Text(
                  'To Menu',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0XFFAEBBDD)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)))),
              )),
        ],
      ),
    );
  }
}
