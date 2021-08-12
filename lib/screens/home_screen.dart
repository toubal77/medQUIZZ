import 'package:flutter/material.dart';
import 'package:med_quizz/models/modules.dart';
import 'package:med_quizz/screens/profile_screen.dart';
import 'package:med_quizz/screens/quizz_screen.dart';
import 'package:med_quizz/screens/search_screen.dart';
import 'package:med_quizz/services/database.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List _events = [
  //   {
  //     'image': 'assets/images/Rectangle 5.png',
  //     'nom': 'Montagne tikajda',
  //     'date': '14 juil',
  //     'price': '1200 DA',
  //   },
  //   {
  //     'image': 'assets/images/Rectangle 5 1.png',
  //     'nom': 'Plage sauvage',
  //     'date': '14 juil',
  //     'price': '1200 DA',
  //   },
  //   {
  //     'image': 'assets/images/Rectangle 5 2.png',
  //     'nom': 'Kayak adventure',
  //     'date': '22 juil',
  //     'price': '3200 DA',
  //   }
  // ];
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFE5E5E5),
      // appBar: AppBar(
      //   title: Text('Med QUIZZ'),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.search),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         Navigator.of(context).push(
      //           MaterialPageRoute(
      //             builder: (context) {
      //               return ProfileScreen();
      //             },
      //           ),
      //         );
      //       },
      //       icon: Icon(Icons.account_circle),
      //     ),
      //   ],
      // ),
      drawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: 1000,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffd1abbd), Color(0xffb5487e)],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Modules',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      '1 er annee',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      '2 eme annee',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      '3 eme annee',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      '4 eme annee',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      '5 eme annee',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      '6 eme annee',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      '7 eme annee',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_page.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              'Med QUIZZ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return SearchScreen();
                                          },
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.search),
                                    color: Colors.blue,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ProfileScreen();
                                          },
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.account_circle,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bonjour',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 220,
                              child: Text(
                                'Doctor toubal zine eddine',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 400,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    padding: const EdgeInsets.all(15.0),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 5, bottom: 10, left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0.3, 0.3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(
                              Icons.sports_score,
                              size: 70,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Mes scores',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 5, bottom: 10, left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0.3, 0.3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(
                              Icons.favorite,
                              size: 70,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Module Favoris',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 5, bottom: 10, left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0.3, 0.3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(
                              Icons.school,
                              size: 70,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Modules',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 5, bottom: 10, left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0.3, 0.3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(
                              Icons.account_circle,
                              size: 70,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                  child: Text(
                    'Module Populare',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  height: 270,
                  child: FutureBuilder<List<Modules?>?>(
                    future: DatabaseMethods().getModules(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (contex, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return QuizzPlay();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 4, right: 23),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 235,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          width: 315,
                                          height: 220,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                'https://rayanzinotblans.000webhostapp.com/images/' +
                                                    snapshot.data![index]!.image
                                                        .toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Positioned(
                                        //   bottom: 10,
                                        //   child: Text(
                                        //     snapshot.data![index]!.nom.toString(),
                                        //     style: TextStyle(
                                        //       fontSize: 23,
                                        //       fontWeight: FontWeight.w800,
                                        //       letterSpacing: -0.33,
                                        //       color: Colors.white,
                                        //     ),
                                        //     textAlign: TextAlign.center,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return SizedBox(
                          height: 235.0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: Colors.grey.shade300,
                                child: Container(
                                  width: 315,
                                  height: 220,
                                  margin:
                                      const EdgeInsets.only(top: 4, right: 23),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
