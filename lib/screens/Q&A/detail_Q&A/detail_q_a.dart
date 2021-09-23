import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/Q&A/detail_Q&A/widgets/build_comnt_post.dart';
import 'package:med_quizz/screens/Q&A/detail_Q&A/widgets/header.dart';
import 'package:med_quizz/screens/Q&A/detail_Q&A/widgets/header_post.dart';
import 'package:med_quizz/screens/Q&A/posts/add_post.dart';
import 'package:med_quizz/services/auth.dart';
import 'package:med_quizz/services/database.dart';

enum FilterOptions { supprime, signale, modifie }

class DetailQA extends StatefulWidget {
  final dynamic posts;
  final String idPost;
  const DetailQA(this.posts, this.idPost);

  @override
  _DetailQAState createState() => _DetailQAState();
}

class _DetailQAState extends State<DetailQA> {
  final TextEditingController _messageComm = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String? idUser = AuthService().getUserId;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login-background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                Container(
                  margin:
                      EdgeInsets.only(left: 7.sp, right: 7.sp, bottom: 10.sp),
                  padding:
                      EdgeInsets.only(left: 7.sp, right: 7.sp, bottom: 7.sp),
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
                          HeaderPostDetail(widget.posts),
                          PopupMenuButton(
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.sp),
                                bottomLeft: Radius.circular(10.sp),
                                bottomRight: Radius.circular(10.sp),
                              ),
                            ),
                            onSelected: (FilterOptions selectedValue) {
                              setState(() async {
                                if (selectedValue == FilterOptions.supprime) {
                                  if (widget.posts['idUser'] == idUser) {
                                    DatabaseMethods()
                                        .deletePost(widget.idPost)
                                        .then(
                                      (value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration: Duration(seconds: 3),
                                            content: Text('post deleted'),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  }
                                }
                                if (selectedValue == FilterOptions.signale) {
                                  DatabaseMethods()
                                      .sendSignale(widget.idPost, 'posts')
                                      .then(
                                        (value) => ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration: Duration(seconds: 3),
                                            content: Text(
                                              "Merci d'avoir signale le post, il vas etre traite dans les bref delais",
                                            ),
                                          ),
                                        ),
                                      );
                                }
                                if (selectedValue == FilterOptions.modifie) {
                                  Navigator.of(context).pushNamed(
                                    AddPost.screenName,
                                    arguments: widget.idPost,
                                  );
                                }
                              });
                            },
                            icon: SizedBox(
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
                        margin: EdgeInsets.only(
                          left: 10.sp,
                          right: 10.sp,
                          bottom: 12.sp,
                        ),
                        child: Text(
                          widget.posts['message'].toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (widget.posts['url'] != '')
                        Container(
                          width: MediaQuery.of(context).size.width.w,
                          height: 400,
                          margin: EdgeInsets.only(top: 5.sp, bottom: 12.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.posts['url'].toString(),
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
                      SingleChildScrollView(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .doc(widget.idPost)
                              .collection('commentaires')
                              .orderBy('time', descending: false)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: int.parse(
                                  snapshot.data!.docs.length.toString(),
                                ),
                                itemBuilder: (context, index) {
                                  return BuildCommentePost(
                                    snapshot.data!.docs[index],
                                    snapshot.data!.docs[index].id.toString(),
                                    widget.idPost,
                                  );
                                },
                              );
                            }
                            return CircularProgressIndicator();
                          },
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
                            if (_messageComm.text.trim().isNotEmpty) {
                              DatabaseMethods()
                                  .sendCommentaire(
                                widget.idPost,
                                _messageComm.text.trim(),
                              )
                                  .then((result) async {
                                _messageComm.text = '';
                                print('send message');
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 3),
                                    content: Text(
                                      'error to send post message commentaire$error',
                                    ),
                                  ),
                                );
                              });
                            }
                          },
                          backgroundColor: _messageComm.text.trim().isEmpty
                              ? Colors.grey
                              : Colors.blue,
                          elevation: 0,
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
