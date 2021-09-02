import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/Q&A/widgets/build_image_user.dart';
import 'package:med_quizz/screens/Q&A/widgets/time_name_pop.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeaderPostDetail extends StatelessWidget {
  final post;
  HeaderPostDetail(this.post);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildImageUser(),
        SizedBox(
          width: 7.w,
        ),
        TimeNamePost(
          post['username'],
          timeago.format(
            DateTime.parse(
              post['time'].toString(),
            ),
          ),
        ),
      ],
    );
  }
}
