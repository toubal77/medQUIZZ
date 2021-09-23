import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:med_quizz/helper/controller.dart';

class ProgressBar extends StatefulWidget {
  final bool timeOver;
  final String title;
  const ProgressBar({
    Key? key,
    required this.timeOver,
    required this.title,
  }) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width.w,
            height: 30,
            margin: EdgeInsets.only(top: 5.sp, bottom: 10.sp),
            child: RichText(
              text: TextSpan(
                text: 'QUIZZ ',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.title,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF3F4768), width: 3.w),
            borderRadius: BorderRadius.circular(50.sp),
          ),
          child: GetBuilder<QuestionController>(
            init: QuestionController(),
            builder: (controller) {
              return Stack(
                children: [
                  // LayoutBuilder provide us the available space for the conatiner
                  // constraints.maxWidth needed for our animation
                  LayoutBuilder(
                    builder: (context, constraints) => Container(
                      // from 0 to 1 it takes 60s
                      width:
                          constraints.maxWidth.sp * controller.animation.value,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
                        ),
                        borderRadius: BorderRadius.circular(50.sp),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${(controller.animation.value * 60).round()} sec",
                          ),
                          const Icon(Icons.lock_clock),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
