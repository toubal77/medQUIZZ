import 'package:flutter/material.dart';
import 'package:med_quizz/screens/profile/components/profile_menu.dart';
import 'package:med_quizz/screens/profile/screens/change_password.dart';
import 'package:med_quizz/screens/profile/widgets/header_profile.dart';
import 'package:med_quizz/screens/profile/widgets/user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                    HeaderProfile(title: 'Profile'),
                    UserInfo(),
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
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangePassword();
                        },
                      ),
                    );
                  },
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
