import 'package:bellehouse/services/auth/auth_service.dart';
import 'package:bellehouse/utilities/dialogs/logout_dialog.dart';
import 'package:bellehouse/utilities/home_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //sign user out
  void signOut() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  Position? _currentPosition;
  String? _currentAddress;
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
            );
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
          color: const Color(0xFF6C63FF),
        ),
        title: const Text("Profile screen"),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
            color: Colors.black,
          ),
        ],
      ),
      body: Column(
        children: [
          //profile picture
          const SizedBox(
            width: 90,
            height: 90,
            child: CircleAvatar(
              backgroundImage: AssetImage("lib/assets/profile.jpg"),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Alice Johnson'),
          const Text('Numero: +227 88 00 00 00'),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                side: BorderSide.none,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'Editer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 10),

          //MENU

          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: const Icon(
                            LineAwesomeIcons.cog,
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Parametres',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: const Icon(
                        LineAwesomeIcons.angle_right,
                        color: Color(0xFF6C63FF),
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Deconnexion',
                        style: TextStyle(fontSize: 13),
                      ),
                      IconButton(
                        onPressed: () async {
                          final shouldLogOut = await showLougOutDialog(context);
                          if (shouldLogOut) {
                            try {
                              signOut();
                            } catch (e) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString(),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        //insert a LineAwesome Icon signout
                        icon: const Icon(
                          Icons.logout,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_currentAddress != null)
                  Text(
                    // "LAT: ${_currentPosition!.latitude}, LON: ${_currentPosition!.longitude}",
                    _currentAddress!,
                  ),
                TextButton(
                  onPressed: () {
                    _getCurrentLocation();
                    _getAddressFromLatLng();
                  },
                  child: const Text("Get location"),
                )
              ],
            ),
          ),
        ],
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
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
      // ignore: empty_catches
    } catch (e) {}
  }
}
