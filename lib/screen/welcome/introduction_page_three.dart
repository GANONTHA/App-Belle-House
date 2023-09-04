import 'package:flutter/material.dart';

class IntroductionPageThree extends StatelessWidget {
  const IntroductionPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFF6C63FF),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
              image: const AssetImage(
                "lib/assets/logo.png",
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              width: 359,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "L'IMMOBILIER EN UN CLIC",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'PermanentMarker'),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * .1,
                width: 230,
                child: const Text(
                  'Notifications d\'annonce en temp reel ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
