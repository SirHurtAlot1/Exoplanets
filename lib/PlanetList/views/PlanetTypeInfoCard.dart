import 'package:exoplanets/PlanetList/classes/PlanetTypes.dart';
import 'package:flutter/material.dart';

class PlanetTypeInfoCard extends StatefulWidget {
  final String planetType;

  const PlanetTypeInfoCard({Key? key, required this.planetType}) : super(key: key);

  @override
  State<PlanetTypeInfoCard> createState() => _PlanetTypeInfoCardState();
}

class _PlanetTypeInfoCardState extends State<PlanetTypeInfoCard> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late String cardText;

  void getCardText(){
    if(widget.planetType == PlanetTypes.gasGiantID)
    {
      cardText = PlanetTypes.gasGiant;
    }else
    if(widget.planetType == PlanetTypes.neptuneLikeID)
    {
      cardText = PlanetTypes.neptuneLike;
    }else
    if(widget.planetType == PlanetTypes.superEarthID)
    {
      cardText = PlanetTypes.superEarth;
    }else
    if(widget.planetType == PlanetTypes.terrestrialID)
    {
      cardText = PlanetTypes.terrestrial;
    }else{
      cardText = 'Something went wrong! Reopen me!';
    }

  }

  @override
  void initState() {
    super.initState();
    getCardText();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
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
              child: Text(cardText, style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25
              ),),
            ),
          ),
        ),
      ),
    );
  }
}
