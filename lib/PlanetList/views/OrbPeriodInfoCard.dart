import 'package:flutter/material.dart';

class OrbPeriodInfoCard extends StatefulWidget {
  final String period;

  const OrbPeriodInfoCard({Key? key, required this.period})
      : super(key: key);

  @override
  State<OrbPeriodInfoCard> createState() => _OrbPeriodInfoCardState();
}

class _OrbPeriodInfoCardState extends State<OrbPeriodInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late String cardText;

  void getCardText(double period) {
    if(period<=100){
      cardText = 'Orbital period is time which planet needs to make full trip around it`s star'
          '\n'
          '\nThis planet is quite fast and makes it`s trip for around ${period.round()} x Day';
    }else if(period<=1000){
      cardText = 'Orbital period is time which planet needs to make full trip around it`s star'
          '\n'
          '\nThis planet makes it`s trip for around ${period.round()} x Day';
    }else{
      cardText = 'Orbital period is time which planet needs to make full trip around it`s star'
          '\n'
          '\nThis planet makes it`s trip for around ${(period/366).round()} x Year';
    }



  }

  @override
  void initState() {
    super.initState();
    getCardText(double.parse(widget.period));
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
