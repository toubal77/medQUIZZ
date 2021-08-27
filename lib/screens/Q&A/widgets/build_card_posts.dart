import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/Q&A/detail_Q&A/detail_q_a.dart';
import 'package:med_quizz/screens/Q&A/widgets/build_image_user.dart';
import 'package:med_quizz/screens/Q&A/widgets/time_name_pop.dart';
import 'package:timeago/timeago.dart' as timeago;

class BuildCardPosts extends StatefulWidget {
  final posts;
  BuildCardPosts(this.posts);

  @override
  _BuildCardPostsState createState() => _BuildCardPostsState();
}

class _BuildCardPostsState extends State<BuildCardPosts> {
  late bool showPopMenu;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailQA(widget.posts);
            },
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width.w,
        margin:
            EdgeInsets.only(top: 4.sp, left: 7.sp, right: 7.sp, bottom: 15.sp),
        padding:
            EdgeInsets.only(top: 7.sp, left: 7.sp, right: 7.sp, bottom: 7.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0.7, 0.7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildImageUser(),
                    SizedBox(
                      width: 7.w,
                    ),
                    TimeNamePost(
                      widget.posts['username'],
                      timeago.format(
                        DateTime.parse(
                          widget.posts['time'].toString(),
                        ),
                      ),
                    ),
                  ],
                ),
                PopupMenuButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.sp),
                    bottomLeft: Radius.circular(10.sp),
                    bottomRight: Radius.circular(10.sp),
                  )),
                  onSelected: (FilterOptions selectedValue) {
                    setState(() {
                      if (selectedValue == FilterOptions.reportthispost) {
                        showPopMenu = true;
                      } else {
                        showPopMenu = false;
                      }
                    });
                  },
                  icon: Container(
                    height: 15.h,
                    child: Icon(
                      Icons.more_horiz,
                    ),
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: FilterOptions.reportthispost,
                      child: SizedBox(
                        width: 70.w,
                        height: 60.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              'Singaler',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(0.85),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                              child: Divider(
                                height: 2.h,
                                color: Colors.black.withOpacity(0.85),
                              ),
                            ),
                            Text(
                              'Supprimer',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(0.85),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width.w,
              margin: EdgeInsets.only(left: 10.sp, right: 10.sp, bottom: 12.sp),
              child: Text(
                widget.posts['message'],
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            ),
            if (widget.posts['url'] != '')
              Container(
                width: MediaQuery.of(context).size.width.w,
                height: 200,
                margin: EdgeInsets.only(top: 5.sp, bottom: 12.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  image: DecorationImage(
                    image: NetworkImage(widget.posts['url']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Divider(
              height: 2.h,
              color: Colors.black.withOpacity(0.85),
            ),
            Container(
              margin: EdgeInsets.only(top: 3, bottom: 3),
              alignment: Alignment.center,
              child: Text(
                'Laissez un commentaire',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Divider(
              height: 2.h,
              color: Colors.black.withOpacity(0.85),
            ),
          ],
        ),
      ),
    );
  }
}
