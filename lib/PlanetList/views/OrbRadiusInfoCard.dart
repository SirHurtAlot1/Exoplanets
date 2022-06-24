import 'package:flutter/material.dart';

class OrbRadiusInfoCard extends StatefulWidget {
  final String radius;

  const OrbRadiusInfoCard({Key? key, required this.radius})
      : super(key: key);

  @override
  State<OrbRadiusInfoCard> createState() => _OrbRadiusInfoCardState();
}

class _OrbRadiusInfoCardState extends State<OrbRadiusInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late String cardText;

  void getCardText(double rad) {

    var kmRad = (rad*1.496*100000000).round();
    cardText = 'AU is an Astronomic Unit. AU is a unit of length, the distance between our Earth and Sun'
        '\n'
        '\nAU is equal about 150 million kilometres'
        '\n'
        '\nThe orbital radius of this planet is about $kmRad kilometres';


  }

  @override
  void initState() {
    super.initState();
    getCardText(double.parse(widget.radius));
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
