import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/Q&A/posts/widget/header.dart';
import 'package:med_quizz/screens/Q&A/posts/widget/info_user.dart';
import 'package:med_quizz/services/database.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController textController = TextEditingController();
  late File? _image;
  bool okok = false;
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
      okok = true;
    });
  }

  Future _submitForm() async {
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    DatabaseMethods()
        .sendPost(textController.text, _image)
        .then((result) async {
      textController.text = '';
      _image = null;
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text('error to send post message' + error.toString()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              UserInfo(),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(
                      top: 8.sp, left: 12.sp, right: 12.sp, bottom: 8.sp),
                  //    padding: EdgeInsets.all(12.sp),

                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey.shade600,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        gapPadding: 12.sp,
                      ),
                      hintText: 'Avez vous une question ?',
                      hintStyle: TextStyle(
                        fontSize: 15.0.sp,
                        color: Colors.grey,
                      ),
                      errorStyle: TextStyle(
                        fontSize: 10.0.sp,
                        color: Colors.redAccent,
                      ),
                    ),
                    cursorColor: Colors.grey.shade300,
                    maxLines: 8,
                    maxLength: 700,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ne doit pas etre vide';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      textController.text = value!;
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width.w,
                margin: EdgeInsets.only(left: 7.sp, right: 7.sp, bottom: 7.sp),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: getImage,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'selection un fichier',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    okok == false
                        ? Text(
                            'aucun fichier',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            'fichier selectionne',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                    if (okok == true)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _image = null;
                            okok = false;
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                  ],
                ),
              ),
              GestureDetector(
                onTap: _submitForm,
                child: Container(
                  width: MediaQuery.of(context).size.width.w,
                  padding: EdgeInsets.symmetric(vertical: 15.sp),
                  margin: EdgeInsets.only(
                    top: 15.sp,
                    left: 40.sp,
                    right: 40.sp,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(2.sp, 4.sp),
                        blurRadius: 5.sp,
                        spreadRadius: 2.sp,
                      )
                    ],
                  ),
                  child: Text(
                    'publier',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
