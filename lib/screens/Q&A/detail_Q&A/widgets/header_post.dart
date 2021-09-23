import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:med_quizz/screens/Q&A/detail_Q&A/widgets/time_name.dart';
import 'package:med_quizz/screens/Q&A/widgets/build_image_user.dart';

class HeaderPostDetail extends StatelessWidget {
  final dynamic post;
  const HeaderPostDetail({
    Key? key,
    required this.post,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BuildImageUser(),
        SizedBox(
          width: 7.w,
        ),
        TimeNamePostDetail(
        username:  post['username'].toString(),
        time:  timeago.format(
            DateTime.parse(
              post['time'].toString(),
            ),
          ),
        ),
      ],
    );
  }
}
