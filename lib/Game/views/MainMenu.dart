import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exoplanets/Game/views/RulePage.dart';
import 'package:exoplanets/Game/views/SpacescapePage.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Random random = Random();
    int index;
    QueryDocumentSnapshot randomPlanetName;
    CollectionReference openedPlanets = FirebaseFirestore.instance.collection('openedPlanets');




    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('exoplanets').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  color: Color(0xff5c56c1),
                ),
              ),
            );
          } else {
            index = random.nextInt(snapshot.data!.size);
            randomPlanetName = snapshot.data!.docs[index];

          }
          return Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(backgroundColor: Colors.transparent,),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/space.jpg'),
                      fit: BoxFit.cover)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Going to\n' + randomPlanetName.get('PlanetName'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 33,
                            fontWeight: FontWeight.w800,
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
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SpacescapePage(snapshot, index)));
                          },
                          child: Text('Start',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0XFFAEBBDD)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)))),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RulePage(planetName: randomPlanetName.get('PlanetName'))));
                          },
                          child: Text(
                            'Rules',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0XFFAEBBDD)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)))),
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
