import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late int _correctAns;
  int get correctAns => this._correctAns;

  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward();

    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
  }

  // void nextQuestion() {
  //   if (_questionNumber.value != _questions.length) {
  //     _isAnswered = false;
  //     _pageController.nextPage(
  //         duration: Duration(milliseconds: 250), curve: Curves.ease);

  //     // Reset the counter
  //     _animationController.reset();

  //     // Then start it again
  //     // Once timer is finish go to the next qn
  //     _animationController.forward().whenComplete(nextQuestion);
  //   } else {
  //     // Get package provide us simple way to naviigate another page
  //     Get.to(ScoreScreen());
  //   }
  // }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
