import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/Q&A/detail_Q&A/detail_q_a.dart';
import 'package:med_quizz/screens/Q&A/posts/add_post.dart';
import 'package:med_quizz/screens/Q&A/widgets/build_image_user.dart';
import 'package:med_quizz/screens/Q&A/widgets/time_name_pop.dart';
import 'package:med_quizz/services/auth.dart';
import 'package:med_quizz/services/database.dart';
import 'package:timeago/timeago.dart' as timeago;

enum FilterOptions { supprime, signale, modifie }

class BuildCardPosts extends StatefulWidget {
  final posts;
  final idPost;
  BuildCardPosts(this.posts, this.idPost);

  @override
  _BuildCardPostsState createState() => _BuildCardPostsState();
}

class _BuildCardPostsState extends State<BuildCardPosts> {
  @override
  Widget build(BuildContext context) {
    String? idUser = AuthService().getUserId;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailQA(widget.posts, widget.idPost);
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
                    setState(() async {
                      if (selectedValue == FilterOptions.supprime) {
                        if (widget.posts['idUser'] == idUser) {
                          DatabaseMethods().deletePost(widget.idPost).then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 3),
                                      content: Text('post deleted'),
                                    ),
                                  ));
                        }
                      }
                      if (selectedValue == FilterOptions.signale) {
                        DatabaseMethods()
                            .sendSignale(widget.idPost, 'posts')
                            .then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 3),
                                  content: Text(
                                      'Merci d\'avoir signale le post, il vas etre traite dans les bref delais'),
                                ),
                              ),
                            );
                      }
                      if (selectedValue == FilterOptions.modifie) {
                        Navigator.of(context).pushNamed(AddPost.screenName,
                            arguments: widget.idPost);
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
                      value: FilterOptions.signale,
                      child: SizedBox(
                        width: 70.w,
                        // height: 60.h,
                        child: Text(
                          'Singaler',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.85),
                          ),
                        ),
                      ),
                    ),
                    if (widget.posts['idUser'] == idUser)
                      PopupMenuItem(
                        value: FilterOptions.supprime,
                        child: SizedBox(
                          width: 70.w,
                          //    height: 60.h,
                          child: Text(
                            'Supprimer',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(0.85),
                            ),
                          ),
                        ),
                      ),
                    if (widget.posts['idUser'] == idUser)
                      PopupMenuItem(
                        value: FilterOptions.modifie,
                        child: SizedBox(
                          width: 70.w,
                          //    height: 60.h,
                          child: Text(
                            'modifie',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(0.85),
                            ),
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
