import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exoplanets/Game/classes/SpacescapeGame.dart';
import 'package:exoplanets/Game/views/MainMenu.dart';
import 'package:exoplanets/PlanetList/views/PlanetListPage.dart';
import 'package:flutter/material.dart';

class PlanetOpenedMenu extends StatelessWidget {
  static const String ID = 'PlanetOpenedMenu';
  final SpacescapeGame gameRef;
  final AsyncSnapshot<QuerySnapshot> planets;
  final int index;
  const PlanetOpenedMenu({Key? key, required this.gameRef, required this.planets, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference openedPlanets = FirebaseFirestore.instance.collection('openedPlanets');
    Future<void> addPlanet(QueryDocumentSnapshot randomPlanet){
      return openedPlanets.add({
        'Description':randomPlanet.get('Description'),
        'DetectionMethod':randomPlanet.get('DetectionMethod'),
        'DiscoveryYear':randomPlanet.get('DiscoveryYear'),
        'Distance':randomPlanet.get('Distance'),
        'HostStar':randomPlanet.get('HostStar'),
        'Mass':randomPlanet.get('Mass'),
        'MassUnit':randomPlanet.get('MassUnit'),
        'OrbitalPeriod':randomPlanet.get('OrbitalPeriod'),
        'OrbitalRadius':randomPlanet.get('OrbitalRadius'),
        'PlanetName':randomPlanet.get('PlanetName'),
        'PlanetRadius':randomPlanet.get('PlanetRadius'),
        'PlanetRadiusUnit':randomPlanet.get('PlanetRadiusUnit'),
        'PlanetType':randomPlanet.get('PlanetType'),
        'Shortcut':randomPlanet.get('Shortcut'),
      });
    }
    addPlanet(planets.data!.docs[index]);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(

              'You have opened\n' + planets.data!.docs[index].get('PlanetName'),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 35,
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context)=>PlanetListPage()));


                },
                child: Text('Check it',
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
                  gameRef.overlays.remove('PlanetOpenedMenu');
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
