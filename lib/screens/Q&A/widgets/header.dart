import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.blue,
                ),
                Text(
                  'Q & A',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
