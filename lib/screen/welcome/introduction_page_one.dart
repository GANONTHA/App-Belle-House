import 'package:flutter/material.dart';

class IntroductionPageOne extends StatelessWidget {
  const IntroductionPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
          color: const Color(0xFF6C63FF),
          child: const Column(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image(
                image: AssetImage(
                  "lib/assets/logo.png",
                ),
                height: 404.33,
                width: 359,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "L'IMMOBILIER EN UN CLIC",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'PermanentMarker'),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                  height: 200.0,
                  width: 230,
                  child: Text(
                    'Trouver une maison qui vous convient sans vous deplacer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ))
            ],
          )),
    );
  }
}
