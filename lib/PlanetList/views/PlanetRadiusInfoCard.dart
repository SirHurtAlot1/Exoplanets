import 'package:flutter/material.dart';

class PlanetRadiusInfoCard extends StatefulWidget {
  final String radius;
  final String radUnit;

  const PlanetRadiusInfoCard({Key? key, required this.radius, required this.radUnit})
      : super(key: key);

  @override
  State<PlanetRadiusInfoCard> createState() => _PlanetRadiusInfoCardState();
}

class _PlanetRadiusInfoCardState extends State<PlanetRadiusInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late String cardText;

  void getCardText(double rad, String radUnit) {

    var kmRad;
    if(radUnit == 'Earth'){
      kmRad = (rad*6371).round();
      cardText = 'Radius of a planet is distance from its core to the surface'
          '\nEarth radius is about 6371 kilometres'
          '\n'
          '\nThe radius of this planet is about $rad times of our own Earth radius'
          '\n'
          '\nIt`s about $kmRad kilometres';

    }else{
      kmRad = (rad*69911).round();
      cardText = 'Radius of a planet is distance from its core to the surface'
          '\nJupiter radius is about 69911 kilometres'
          '\n'
          '\nThe radius of this planet is about $rad times of our own Jupiter radius'
          '\n'
          '\nIt`s about $kmRad kilometres';
    }


  }

  @override
  void initState() {
    super.initState();
    getCardText(double.parse(widget.radius), widget.radUnit);
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      this.setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                cardText,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
