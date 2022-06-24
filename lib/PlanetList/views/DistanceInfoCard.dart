import 'package:flutter/material.dart';

class DistanceInfoCard extends StatefulWidget {
  final String distance;

  const DistanceInfoCard({Key? key, required this.distance})
      : super(key: key);

  @override
  State<DistanceInfoCard> createState() => _DistanceInfoCardState();
}

class _DistanceInfoCardState extends State<DistanceInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late String cardText;

  void getCardText(int distance) {
    var kmDistance = (distance*9.46).round();
    if (distance >= 500) {
      cardText =
          'Light year is a distance traveled by light for one year.'
          '\n'
              '\nThis planet is very very far away from Earth.'
          '\n'
              '\n$distance x Light year is about $kmDistance x 10^12 km';
    }else{
      cardText =
      'Light year is a distance traveled by light for one year.'
      '\n'
          '\nThis planet not so far from Earth in a Cosmic scale.'
      '\n'
          '\n$distance x Light year is about $kmDistance x 10^12 km';
    }
  }

  @override
  void initState() {
    super.initState();
    getCardText(int.parse(widget.distance));
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
