import 'package:flutter/material.dart';

import 'package:med_quizz/models/questions.dart';
import 'package:med_quizz/screens/quizz/components/progress_bar.dart';
import 'package:med_quizz/screens/quizz/widgets/quiz_play_tile.dart';
import 'package:med_quizz/services/database.dart';

class QuizzPlay extends StatefulWidget {
  const QuizzPlay({Key? key}) : super(key: key);

  @override
  _QuizzPlayState createState() => _QuizzPlayState();
}

class _QuizzPlayState extends State<QuizzPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                Container(
                  height: 35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Stack(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
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
                                  fontSize: 20,
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
        child: Icon(Icons.coronavirus),
        onPressed: () {},
      ),
    );
  }

  Widget quizList() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
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
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
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
                          height: 10,
                        ),
                        ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return QuizPlayTile(
                              questionModel: snapshot.data![index],
                              index: index,
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
