import 'package:flutter/material.dart';

class RulePage extends StatelessWidget {
  final String planetName;
  const RulePage({Key? key, required this.planetName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: Colors.transparent,),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/space.jpg'),
                  fit: BoxFit.cover)),
          child: Center(
            child: Text(
                'Your goal is to reach $planetName by collecting energy from meteor field.'
                    '\n'
                    '\nTo achieve this goal you need to use your ship`s guns and destroy meteors to take their energy.'
                    '\n'
                    '\nWhen your achieve energy level of 5 you will make hyperjump to the planet.'
                    '\n'
                    '\nBe careful and don`t get direct hit from meteor.'
                    '\n'
                    'In this case you will gain energy, but durability of your ship will be reduced.'
                    '\n'
                    '\nReducing durability to 0 may cause destroying of your ship',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xffa5aecf),
                    fontWeight: FontWeight.w600,
                    fontSize: 25)),
          ),
          ),
        );
  }
}
