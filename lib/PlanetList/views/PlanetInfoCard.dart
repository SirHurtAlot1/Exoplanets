import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:exoplanets/PlanetList/views/DetMethodInfoCard.dart';
import 'package:exoplanets/PlanetList/views/PlanetRadiusInfoCard.dart';
import 'package:exoplanets/PlanetList/views/PlanetTypeInfoCard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'DistanceInfoCard.dart';
import 'MassInfoCard.dart';
import 'OrbPeriodInfoCard.dart';
import 'OrbRadiusInfoCard.dart';

class PlanetInfoCard extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;
  final ScrollController sc;
  const PlanetInfoCard(
      {Key? key, required this.snapshot, required this.index, required this.sc})
      : super(key: key);

  String getOrbitalPeriod(String period) {
    var newPeriod = double.parse(period);
    String per;
    if (newPeriod >= 1000) {
      per = ((newPeriod / 366).round()).toString() + ' x Year';
    } else {
      per = period + ' x Day';
    }
    return per;
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle leftGridTextStyle = TextStyle(
        fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white);
    const TextStyle rightGridTextStyle = TextStyle(
        fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        controller: sc,
        children: [
          BlurryContainer(
            borderRadius: BorderRadius.circular(30),
            blur: 10,
            color: Colors.white12,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlurryContainer(
                    width: double.infinity,
                    blur: 0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('star',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600)),
                          Text(snapshot.data!.docs[index].get('HostStar'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              snapshot.data!.docs[index].get('Description'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ]),
                  ),
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('PLANET TYPE',
                                      style: leftGridTextStyle)),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                      text: TextSpan(
                                          text: snapshot.data!.docs[index]
                                                  .get('PlanetType') +
                                              ' 🔎',
                                          style: rightGridTextStyle,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      PlanetTypeInfoCard(
                                                    planetType: snapshot
                                                        .data!.docs[index]
                                                        .get('PlanetType'),
                                                  ),
                                                )))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('DISTANCE',
                                      style: leftGridTextStyle)),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                      text: TextSpan(
                                          text: snapshot.data!.docs[index]
                                                  .get('Distance') +
                                              ' x Light Year' +
                                              ' 🔎',
                                          style: rightGridTextStyle,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DistanceInfoCard(
                                                    distance: snapshot
                                                        .data!.docs[index]
                                                        .get('Distance'),
                                                  ),
                                                )))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('DISCOVERED IN',
                                      style: leftGridTextStyle)),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      snapshot.data!.docs[index]
                                          .get('DiscoveryYear'),
                                      style: rightGridTextStyle)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                      Text('MASS', style: leftGridTextStyle)),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                      text: TextSpan(
                                          text: snapshot.data!.docs[index]
                                                  .get('Mass') +
                                              ' x ' +
                                              snapshot.data!.docs[index]
                                                  .get('MassUnit') +
                                              '🔎',
                                          style: rightGridTextStyle,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      MassInfoCard(
                                                    mass: snapshot
                                                        .data!.docs[index]
                                                        .get('Mass'),
                                                    massUnit: snapshot
                                                        .data!.docs[index]
                                                        .get('MassUnit'),
                                                  ),
                                                )))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('PLANET RADIUS',
                                      style: leftGridTextStyle)),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                      text: TextSpan(
                                          text: snapshot.data!.docs[index]
                                                  .get('PlanetRadius') +
                                              ' x ' +
                                              snapshot.data!.docs[index]
                                                  .get('PlanetRadiusUnit') +
                                              '🔎',
                                          style: rightGridTextStyle,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      PlanetRadiusInfoCard(
                                                    radius: snapshot
                                                        .data!.docs[index]
                                                        .get('PlanetRadius'),
                                                    radUnit: snapshot
                                                        .data!.docs[index]
                                                        .get(
                                                            'PlanetRadiusUnit'),
                                                  ),
                                                )))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('ORBITAL RADIUS',
                                      style: leftGridTextStyle)),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                      text: TextSpan(
                                          text: snapshot.data!.docs[index]
                                                  .get('OrbitalRadius') +
                                              ' x AU' +
                                              '🔎',
                                          style: rightGridTextStyle,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    OrbRadiusInfoCard(
                                                      radius: snapshot
                                                          .data!.docs[index]
                                                          .get('OrbitalRadius'),
                                                    ))))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('ORBITAL PERIOD',
                                      style: leftGridTextStyle)),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                      text: TextSpan(
                                          text: getOrbitalPeriod(snapshot
                                                  .data!.docs[index]
                                                  .get('OrbitalPeriod')) +
                                              '🔎',
                                          style: rightGridTextStyle,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    OrbPeriodInfoCard(
                                                      period: snapshot
                                                          .data!.docs[index]
                                                          .get('OrbitalPeriod'),
                                                    ))))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('DETECTION\nMETHOD',
                                      style: leftGridTextStyle)),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                      text: TextSpan(
                                          text: snapshot.data!.docs[index]
                                                  .get('DetectionMethod') +
                                              ' 🔎',
                                          style: rightGridTextStyle,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    DetMethodInfoCard(
                                                      method: snapshot
                                                          .data!.docs[index]
                                                          .get(
                                                              'DetectionMethod'),
                                                    ))))),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
