import 'package:flutter/material.dart';

class DetMethodInfoCard extends StatefulWidget {
  final String method;

  const DetMethodInfoCard({Key? key, required this.method}) : super(key: key);

  @override
  State<DetMethodInfoCard> createState() => _DetMethodInfoCardState();
}

class _DetMethodInfoCardState extends State<DetMethodInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late String cardText;

  void getCardText(String method) {
    if (method == 'Transit') {
      cardText = 'When a planet passes directly between its star and an observer on Earth, it dims the star`s light by a measurable amount';

    } else if (method == 'Radial Velocity') {
      cardText =
      'Orbiting planets cause star to wobble in space, changing the color of the light astronomers observe'
          '\n'
          '\nIt is  possible because the planet have gravitation impact on its star';

    }
  }

  @override
  void initState() {
    super.initState();
    getCardText(widget.method);
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
