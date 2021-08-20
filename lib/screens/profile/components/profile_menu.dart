import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? press;
  const ProfileMenu(this.title, this.icon, this.press);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        padding: EdgeInsets.all(20.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
        //color: Color(0xFFE5E5E5),
        color: Colors.white54.withOpacity(0.38.sp),
        onPressed: press,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.blue,
            ),
            SizedBox(
              width: 20.0.w,
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
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
