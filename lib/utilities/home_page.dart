import 'package:bellehouse/screen/chat_screen.dart';
import 'package:bellehouse/screen/favorite_screen.dart';
import 'package:bellehouse/screen/home_screen.dart';
import 'package:bellehouse/screen/profile_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //bottom screens
  int currentTab = 0;
  final List<Widget> screens = [
    const Home(),
    const Favorites(),
    const Chat(),
    const Profile(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Home();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color:
                              currentTab == 0 ? Colors.black : Colors.grey[400],
                        ),
                        Text(
                          "Accueil",
                          style: TextStyle(
                              color: currentTab == 0
                                  ? Colors.black
                                  : Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Favorites();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          color:
                              currentTab == 1 ? Colors.black : Colors.grey[400],
                        ),
                        Text(
                          "Favoris",
                          style: TextStyle(
                              color: currentTab == 1
                                  ? Colors.black
                                  : Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //Right icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Chat();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          color:
                              currentTab == 2 ? Colors.black : Colors.grey[400],
                        ),
                        Text(
                          "Message",
                          style: TextStyle(
                              color: currentTab == 2
                                  ? Colors.black
                                  : Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Profile();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color:
                              currentTab == 3 ? Colors.black : Colors.grey[400],
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                              color: currentTab == 3
                                  ? Colors.black
                                  : Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
          
          //bottom navigation bar
        

