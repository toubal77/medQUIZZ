import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:med_quizz/screens/Q&A/widgets/build_image_user.dart';
import 'package:med_quizz/services/auth.dart';
import 'package:med_quizz/services/database.dart';

enum FilterOptions { supprime, signale }

class BuildCommentePost extends StatefulWidget {
  final dynamic comnt;
  final String idComnt;
  final String idPost;
  const BuildCommentePost({
    Key? key,
    required this.comnt,
    required this.idComnt,
    required this.idPost,
  }) : super(key: key);

  @override
  _BuildCommentePostState createState() => _BuildCommentePostState();
}

class _BuildCommentePostState extends State<BuildCommentePost> {
  @override
  Widget build(BuildContext context) {
    final String? idUser = AuthService().getUserId;
    return Container(
      width: MediaQuery.of(context).size.width.w,
      padding: EdgeInsets.all(7.sp),
      child: Row(
        children: [
          const BuildImageUser(),
          SizedBox(
            width: 7.w,
          ),
          Container(
            width: MediaQuery.of(context).size.width.w * 0.6,
            margin: EdgeInsets.only(top: 7.sp, bottom: 7.sp, right: 7.sp),
            padding: EdgeInsets.only(left: 7.sp, right: 7.sp, bottom: 7.sp),
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width.w * 0.4,
                      child: Text(
                        widget.comnt['username'].toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.sp),
                          bottomLeft: Radius.circular(10.sp),
                          bottomRight: Radius.circular(10.sp),
                        ),
                      ),
                      onSelected: (FilterOptions selectedValue) {
                        setState(
                          () async {
                            if (selectedValue == FilterOptions.supprime) {
                              if (widget.comnt['idUser'] == idUser) {
                                DatabaseMethods()
                                    .deleteComnt(
                                      widget.idPost,
                                      widget.idComnt,
                                    )
                                    .then(
                                      (value) => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 3),
                                          content: Text('commentaire deleted'),
                                        ),
                                      ),
                                    );
                              }
                            }
                            if (selectedValue == FilterOptions.signale) {
                              DatabaseMethods()
                                  .sendSignale(
                                    widget.idComnt,
                                    'commentaire',
                                  )
                                  .then(
                                    (value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 3),
                                        content: Text(
                                          "Merci d'avoir signale le le commentaire, il vas etre traite dans les bref delais",
                                        ),
                                      ),
                                    ),
                                  );
                            }
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
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
                        if (widget.comnt['idUser'] == idUser)
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
                      ],
                    ),
                  ],
                ),
                Text(
                  widget.comnt['message'].toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
