import 'package:bellehouse/Menus/maisons.dart';
import 'package:bellehouse/Menus/meubles.dart';
import 'package:bellehouse/Menus/parcelles.dart';
import 'package:bellehouse/Menus/tout.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

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
//get location
  // void getLocation() async {
  //   await Geolocator.checkPermission();
  //   await Geolocator.requestPermission();

  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  // }

  Widget build(BuildContext context) {
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
                        const Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('Position actuelle'),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Color(0xA11640D8),
                                      ),
                                      Text(
                                        "Niamey-Niger",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('lib/assets/profile.jpg'),
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
                                  color: const Color(0xFFEEEEEE),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: SizedBox(
                                        height: 30,
                                        child: Icon(
                                          Icons.search,
                                          color: Color(0x9E1640D8),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Rechercher',
                                          hintStyle: TextStyle(
                                            color: Color(0x9E1640D8),
                                            letterSpacing: 1.2,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0x9E1640D8),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                height: 40,
                                child: Image.asset(
                                  'lib/assets/filter.png',
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ])
                : const SizedBox(
                    height: 10,
                  ),

            //menu de navigation
            SizedBox(
                height: 70.0,
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    //First menu BUTTON  :  TOUT
                    Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 0;
                            currentScreen = const Tout();
                          });
                        },
                        style: TextButton.styleFrom(
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
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 1;
                            currentScreen = const Maison();
                          });
                        },
                        style: TextButton.styleFrom(
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
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 2;
                            currentScreen = const Parcelle();
                          });
                        },
                        style: TextButton.styleFrom(
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
                      width: 100.0,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            currentTab = 3;
                            currentScreen = const Meuble();
                          });
                        },
                        style: TextButton.styleFrom(
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
              height: 600,
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
}

//get location

Future<LocationData?> _getLocation() async {
  Location location = Location();
  LocationData locationData;

  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();

  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  locationData = await location.getLocation();

  return locationData;
}

//get the address

Future<String> _getAddress(double? lat, double? lang) async {
  if (lat == null || lang == null) return "";
  GeoCode geocode = GeoCode();

  Address address =
      await geocode.reverseGeocoding(latitude: lat, longitude: lang);
  return " ${address.city}, ${address.countryName}";
}
