import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exoplanets/PlanetList/views/PlanetInfoCard.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlanetListPage extends StatefulWidget {
  const PlanetListPage({Key? key}) : super(key: key);

  @override
  State<PlanetListPage> createState() => _PlanetListPageState();
}

class _PlanetListPageState extends State<PlanetListPage> {
  @override
  void initState() {
    super.initState();
  }

  String getPlanetImage(String planetType) {
    String asset = '';
    if (planetType == 'Terrestrial') {
      asset = 'assets/images/Terrestrial.png';
    } else if (planetType == 'Super Earth') {
      asset = 'assets/images/SuperEarth.png';
    } else if (planetType == 'Gas Giant') {
      asset = 'assets/images/GasGiant.png';
    } else if (planetType == 'Neptune-like') {
      asset = 'assets/images/NeptuneLike.png';
    }
    return asset;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('openedPlanets').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Container(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  color: Color(0xff5c56c1),
                ),
              ),
            );
          if (snapshot.data!.docs.length == 0) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
              body: Container(
                  child: Center(
                    child: Text(
                      'You don`t have planets yet!\nHave you played the game?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/space.jpg'),
                          fit: BoxFit.cover))),
            );
          }
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(backgroundColor: Colors.transparent,),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/space.jpg'),
                      fit: BoxFit.cover)),
              child: Center(
                child: CarouselSlider.builder(
                    options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: double.infinity,
                        viewportFraction: 1,
                        enlargeCenterPage: true),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index, realIndex) {
                      return SlidingUpPanel(
                        parallaxEnabled: true,
                        parallaxOffset: 0.7,
                        minHeight: 150,
                        maxHeight: 500,
                        color: Colors.transparent,
                        panelBuilder: (ScrollController sc) => PlanetInfoCard(
                          snapshot: snapshot,
                          index: index,
                          sc: sc,
                        ),
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                Text(
                                  snapshot.data!.docs[index].get('PlanetName'),
                                  //softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 45,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  snapshot.data!.docs[index].get('Shortcut'),
                                  //softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Image.asset(
                              getPlanetImage(snapshot.data!.docs[index].get('PlanetType')),
                              width: 300,
                              height: 300,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          );
        });
  }
}
