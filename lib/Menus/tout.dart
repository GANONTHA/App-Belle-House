import 'package:flutter/material.dart';

class Tout extends StatefulWidget {
  const Tout({super.key});

  @override
  State<Tout> createState() => _ToutState();
}

class _ToutState extends State<Tout> {
  final List<String> menu = <String>['Tout', 'Maison', 'Parcelle', 'Meuble'];
  final List<Color> colorCodes = <Color>[
    const Color(0xA11640D8),
    const Color(0xFFEEEEEE),
    const Color(0xFFEEEEEE),
    const Color(0xFFEEEEEE),
  ];
  final List<Color> textColor = <Color>[
    const Color(0xFFEEEEEE),
    const Color(0xA11640D8),
    const Color(0xA11640D8),
    const Color(0xA11640D8),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          const SizedBox(height: 25),
          //app bar
          const Expanded(
            flex: 1,
            child: Padding(
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
                            'Niamey- Niger',
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
                    backgroundImage: AssetImage('lib/assets/profile.jpg'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          //search bar
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              height: 30,
                              child: Icon(
                                Icons.search,
                                color: Color(0x9E1640D8),
                              ),
                            ),
                          ),
                          Expanded(
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
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0x9E1640D8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 50,
                    child: Image.asset(
                      'lib/assets/filter.png',
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          //menu de navigation
          Expanded(
            flex: 1,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: colorCodes[index],
                    ),
                    width: 100,
                    height: 30,
                    child: TextButton(
                      onPressed: () {},
                      child: Center(
                          child: Text(
                        menu[index],
                        style: TextStyle(color: textColor[index]),
                      )),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),

          //posts: les plus populaires
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Les plus Populaires',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
          ),
          //POSTS

          Expanded(
            flex: 4,
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 150,
                      color: Colors.lightBlue,
                      child: const Center(child: Text('container')),
                    ),
                  );
                }),
          ),
          //posts les plus proches
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Les Plus Proches',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
          ),
          //POSTS

          Expanded(
            flex: 2,
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: const Center(child: Text('container')),
                    ),
                  );
                }),
          ),
        ]));
  }
}
