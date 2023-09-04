import 'package:bellehouse/Menus/maisons.dart';
import 'package:bellehouse/Menus/meubles.dart';
import 'package:bellehouse/Menus/parcelles.dart';
import 'package:bellehouse/Menus/tout.dart';
import 'package:bellehouse/services/auth/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> menu = <String>['Tout', 'Maison', 'Parcelle', 'Meuble'];
  final List<Color> colorCodes = <Color>[
    const Color(0xA11640D8),
    const Color(0xFFEEEEEE),
  ];
  final List<Color> textColor = <Color>[
    const Color(0xFFEEEEEE),
    const Color(0xA11640D8),
  ];
//Manaing the menu display

  int currentTab = 0;
  final List<Widget> screens = [
    const Tout(),
    const Maison(),
    const Parcelle(),
    const Meuble(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Tout();

  Position? _currentPosition;
  String? _currentAddress;
  @override
  void initState() {
    _getCurrentLocation();
    _getAddressFromLatLng();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 25),
            //app bar
            currentTab == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Text('Position actuelle'),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Color(0xA11640D8),
                                      ),
                                      if (_currentAddress != null)
                                        Text(
                                          _currentAddress!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      if (_currentAddress == null)
                                        GestureDetector(
                                          onTap: () {
                                            _getCurrentLocation();
                                            _getAddressFromLatLng();
                                          },
                                          child: const Text(
                                            'Voir Position',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(ap.userModel!.profilePicture),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        //search bar
                        Container(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 3,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                  color: const Color(0xFFEEEEEE),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .9,
                                      child: TextField(
                                        autofocus: false,
                                        cursorColor: const Color(0xA11640D8),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  160, 93, 116, 202),
                                            ),
                                          ),
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Icon(
                                              Icons.search,
                                              color: Color(0x9E1640D8),
                                            ),
                                          ),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0x9E1640D8),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              height: 40,
                                              child: Image.asset(
                                                'lib/assets/filter.png',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue)),
                                          hintText: 'Rechercher',
                                          hintStyle: const TextStyle(
                                            color: Color(0x9E1640D8),
                                            letterSpacing: 1.2,
                                          ),
                                          //  border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])
                : const SizedBox(
                    height: 10,
                  ),

            //menu de navigation
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: ListView(
                  padding: const EdgeInsets.only(left: 0.0, bottom: 4.0),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    //First menu BUTTON  :  TOUT
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      width: 110,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 0;
                            currentScreen = const Tout();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            backgroundColor: currentTab == 0
                                ? colorCodes[0]
                                : colorCodes[1]),
                        child: Text(
                          'Tout',
                          style: TextStyle(
                            color:
                                currentTab == 0 ? textColor[0] : textColor[1],
                          ),
                        ),
                      ),
                    ),
                    //Second Menu button: MAISON
                    Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      width: 110,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 1;
                            currentScreen = const Maison();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            backgroundColor: currentTab == 1
                                ? colorCodes[0]
                                : colorCodes[1]),
                        child: Text(
                          'Maisons',
                          style: TextStyle(
                            color:
                                currentTab == 1 ? textColor[0] : textColor[1],
                          ),
                        ),
                      ),
                    ),
                    //Third menu Button:  PARCELLE

                    Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      width: 110,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 2;
                            currentScreen = const Parcelle();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            backgroundColor: currentTab == 2
                                ? colorCodes[0]
                                : colorCodes[1]),
                        child: Text(
                          'Parcelles',
                          style: TextStyle(
                            color:
                                currentTab == 2 ? textColor[0] : textColor[1],
                          ),
                        ),
                      ),
                    ),
                    //Fourth menu Button:  MEUBLES

                    Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      width: 110.0,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 3;
                            currentScreen = const Meuble();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            backgroundColor: currentTab == 3
                                ? colorCodes[0]
                                : colorCodes[1]),
                        child: Text(
                          'Meubles',
                          style: TextStyle(
                            color:
                                currentTab == 3 ? textColor[0] : textColor[1],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),

            //display Menu content

            SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              //width: 380,
              // color: Colors.blue,
              child: PageStorage(
                bucket: bucket,
                child: currentScreen,
              ),
            ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() async {
    await Geolocator.requestPermission();
    await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      throw (e.code);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}-${place.country}";
      });
      // ignore: empty_catches
    } catch (e) {}
  }
}
