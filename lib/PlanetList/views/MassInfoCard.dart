import 'package:flutter/material.dart';

class MassInfoCard extends StatefulWidget {
  final String mass;
  final String massUnit;

  const MassInfoCard({Key? key, required this.mass, required this.massUnit})
      : super(key: key);

  @override
  State<MassInfoCard> createState() => _MassInfoCardState();
}

class _MassInfoCardState extends State<MassInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late String cardText;

  void getCardText(double mass, String massUnit) {

    var kgMass;
    if(massUnit == 'Earth'){
      kgMass = (mass*5.97).round();
      cardText = 'The mass of this planet is around $mass times of our own Earth'
      '\n'
          '\n$mass x $massUnit is equal about $kgMass x 10^24 kg';
    }else{
      kgMass = (mass*1.9).round();
      cardText = 'The mass of this planet is around $mass times of our own Jupiter'
          '\n'
          '\n$mass x $massUnit is equal about $kgMass x 10^27 kg';
    }


  }

  @override
  void initState() {
    super.initState();
    getCardText(double.parse(widget.mass), widget.massUnit);
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
