import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile'),
      //   centerTitle: true,
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: Icon(Icons.arrow_back),
      //   ),
      // ),
      body: SafeArea(
        child: Container(
          height: 1000,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_page.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 30,
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.blue,
                              ),
                            ),
                            Center(
                              child: Text(
                                'Profile',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 110,
                      margin: EdgeInsets.only(top: 25, bottom: 20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/profile_doctor.jpeg'),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    Text(
                      'toubal zine eddine',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'toubalzineddine77@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                ProfileMenu(
                  'Settings',
                  Icons.settings,
                  () {},
                ),
                ProfileMenu(
                  'Change Password',
                  Icons.lock,
                  () {},
                ),
                ProfileMenu(
                  'Suggections',
                  Icons.help,
                  () {},
                ),
                ProfileMenu(
                  'Note l\'applications',
                  Icons.low_priority_sharp,
                  () {},
                ),
                ProfileMenu(
                  'Partage l\'applications',
                  Icons.share,
                  () {},
                ),
                ProfileMenu(
                  'Log Out',
                  Icons.exit_to_app,
                  () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final press;
  ProfileMenu(this.title, this.icon, this.press);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //color: Color(0xFFE5E5E5),
        color: Colors.white54.withOpacity(0.38),
        onPressed: press,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.blue,
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
