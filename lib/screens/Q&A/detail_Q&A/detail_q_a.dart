import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/Q&A/detail_Q&A/widgets/header.dart';
import 'package:med_quizz/screens/Q&A/widgets/build_image_user.dart';
import 'package:med_quizz/screens/Q&A/widgets/time_name_pop.dart';
import 'package:med_quizz/services/database.dart';
import 'package:timeago/timeago.dart' as timeago;

enum FilterOptions {
  reportthispost,
}

class DetailQA extends StatefulWidget {
  final posts;
  final idPost;
  DetailQA(this.posts, this.idPost);

  @override
  _DetailQAState createState() => _DetailQAState();
}

class _DetailQAState extends State<DetailQA> {
  TextEditingController _messageComm = TextEditingController();
  late bool showPopMenu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_page.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Header(),
              Container(
                margin: EdgeInsets.only(left: 7.sp, right: 7.sp, bottom: 10.sp),
                padding: EdgeInsets.only(left: 7.sp, right: 7.sp, bottom: 7.sp),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                              if (selectedValue ==
                                  FilterOptions.reportthispost) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                      margin: EdgeInsets.only(
                          left: 10.sp, right: 10.sp, bottom: 12.sp),
                      child: Text(
                        widget.posts['message'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width.w,
                      height: 200,
                      margin: EdgeInsets.only(top: 5.sp, bottom: 12.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.posts['url'],
                          ),
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
                        'Les commentaires',
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
                    Container(
                      width: MediaQuery.of(context).size.width.w,
                      padding: EdgeInsets.all(7.sp),
                      child: Row(
                        children: [
                          BuildImageUser(),
                          SizedBox(
                            width: 7.w,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width.w * 0.6,
                            margin: EdgeInsets.only(
                                top: 7.sp, bottom: 7.sp, right: 7.sp),
                            padding: EdgeInsets.all(7.sp),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'toubal zineddine',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'ijhrfjhgoij ldfkjjhlj fhg ijfoijhblj ijhrfjhgoij ldfkjjhlj fhg ijfoijhblj ijhrfjhgoij ldfkjjhlj fhg ijfoijhblj ijhrfjhgoij ldfkjjhlj',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: TextField(
                                autofocus: true,
                                controller: _messageComm,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: "Tapez votre commentaire...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _messageComm.text = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                if (_messageComm.text.trim().length != 0) {
                                  DatabaseMethods()
                                      .sendCommentaire(widget.idPost,
                                          _messageComm.text.trim())
                                      .then((result) async {
                                    _messageComm.text = '';
                                    Navigator.of(context).pop();
                                  }).catchError((error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 3),
                                        content: Text(
                                            'error to send post message commentaire' +
                                                error.toString()),
                                      ),
                                    );
                                  });
                                }
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 18,
                              ),
                              backgroundColor:
                                  _messageComm.text.trim().length == 0
                                      ? Colors.grey
                                      : Colors.blue,
                              elevation: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
