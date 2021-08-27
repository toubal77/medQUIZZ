import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/Q&A/detail_Q&A/detail_q_a.dart';
import 'package:med_quizz/screens/Q&A/widgets/header.dart';
import 'package:timeago/timeago.dart' as timeago;

enum FilterOptions {
  reportthispost,
}

class QAScreen extends StatefulWidget {
  const QAScreen({Key? key}) : super(key: key);

  @override
  _QAScreenState createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  late bool showPopMenu;
  final DateTime? currentTime = new DateTime.now();
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
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData)
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailQA(snapshot.data!.docs[index]);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width.w,
                              margin: EdgeInsets.only(
                                  top: 4.sp,
                                  left: 7.sp,
                                  right: 7.sp,
                                  bottom: 15.sp),
                              padding: EdgeInsets.only(
                                  top: 7.sp,
                                  left: 7.sp,
                                  right: 7.sp,
                                  bottom: 7.sp),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 40.w,
                                            height: 40.h,
                                            margin: EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/profile_doctor.jpeg'),
                                                fit: BoxFit.cover,
                                              ),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(60.sp),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7.w,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10.sp, bottom: 7.sp),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      ['username'],
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                Text(
                                                  timeago.format(
                                                    DateTime.parse(
                                                      snapshot.data!
                                                          .docs[index]['time']
                                                          .toString(),
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
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
                                        onSelected:
                                            (FilterOptions selectedValue) {
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height: 3.h,
                                                  ),
                                                  Text(
                                                    'Singaler',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black
                                                          .withOpacity(0.85),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3.h,
                                                    child: Divider(
                                                      height: 2.h,
                                                      color: Colors.black
                                                          .withOpacity(0.85),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Supprimer',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black
                                                          .withOpacity(0.85),
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
                                        left: 10.sp,
                                        right: 10.sp,
                                        bottom: 12.sp),
                                    child: Text(
                                      snapshot.data!.docs[index]['message'],
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  if (snapshot.data!.docs[index]['url'] != '')
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width.w,
                                      height: 200,
                                      margin: EdgeInsets.only(
                                          top: 5.sp, bottom: 12.sp),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]['url']),
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
                        },
                      );
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
