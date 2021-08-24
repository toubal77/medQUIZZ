import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/models/questions.dart';
import 'package:med_quizz/screens/quizz/components/progress_bar.dart';
import 'package:med_quizz/screens/quizz/widgets/quiz_play_tile.dart';
import 'package:med_quizz/services/database.dart';

class QuizzPlay extends StatefulWidget {
  const QuizzPlay({Key? key}) : super(key: key);

  @override
  _QuizzPlayState createState() => _QuizzPlayState();
}

bool validate = false;

class _QuizzPlayState extends State<QuizzPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_page.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 35.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                        child: Stack(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                validate = false;
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.blue,
                              ),
                            ),
                            Center(
                              child: Text(
                                'QUIZZ',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: quizList(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            validate = true;
          });
        },
        child: Icon(Icons.coronavirus),
      ),
    );
  }

  Widget quizList() {
    return Container(
      margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
      child: Column(
        children: [
          FutureBuilder<List<Questions?>?>(
            future: DatabaseMethods().getQuestions(),
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height.h * 0.4,
                          ),
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text('Chargement...'),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ProgressBar(),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return QuizPlayTile(
                              questionModel: snapshot.data![index],
                              index: index,
                              validate: validate,
                            );
                          },
                        ),
                      ],
                    );
            },
          )
        ],
      ),
    );
  }
}
