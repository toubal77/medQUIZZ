import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    margin: EdgeInsets.only(top: 25, bottom: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/profile_doctor.jpeg'),
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
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
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
              'Terms & Condition',
              Icons.low_priority_sharp,
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
        color: Color(0xFFE5E5E5),
        onPressed: press,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.purple,
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.purple,
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
