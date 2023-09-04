import 'package:bellehouse/screen/welcome/introduction_page_one.dart';
import 'package:bellehouse/screen/welcome/introduction_page_three.dart';
import 'package:bellehouse/screen/welcome/introduction_page_two.dart';
import 'package:bellehouse/services/auth/authProvider.dart';
import 'package:bellehouse/utilities/Authentification/register_screen.dart';
import 'package:bellehouse/utilities/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // controller to keep track of what page we are on
  final PageController _controller = PageController();
  //keep track of if we are on the last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [
            IntroductionPageOne(),
            IntroductionPageTwo(),
            IntroductionPageThree(),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Skip
              GestureDetector(
                  child: const Text(
                    'Ignorer',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _controller.jumpToPage(2);
                  }),
              //dot indicator
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.white,
                    dotHeight: 10,
                    dotWidth: 10),
              ),
              //Next or Done
              onLastPage
                  ? GestureDetector(
                      onTap: () async {
                        if (ap.isSignedIn == true) {
                          await ap.getDataFromSP().whenComplete(
                                () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyHomePage(),
                                  ),
                                ),
                              );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return RegisterPage();
                            }),
                          );
                        }
                      },
                      child: const Text(
                        'Terminer',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Suivant',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.navigate_next_sharp,
                            color: Colors.white,
                            size: 17.0,
                          ),
                        ],
                      ),
                    )
            ],
          ),
        )
      ]),
    );
  }
}
