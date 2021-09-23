import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionTile extends StatefulWidget {
  final String answer; // la question
  final String option; // A B C D E
  final String optionSelected; // est ce que ete selectione == LA QUestion
  final bool correctAnswer; // la reponse
  final bool validate;
  const OptionTile({
    Key? key,
    required this.answer,
    required this.option,
    required this.correctAnswer,
    required this.validate,
    required this.optionSelected,
  }) : super(key: key);

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      padding: EdgeInsets.only(left: 20.sp, right: 10.sp),
      margin: EdgeInsets.only(top: 3.sp, bottom: 3.sp),
      child: Row(
        children: [
          Container(
            height: 28.h,
            width: 28.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.optionSelected == ''
                    ? widget.validate
                        ? widget.correctAnswer
                            ? Colors.green
                            : Colors.red
                        : Colors.white
                    : widget.validate
                        ? widget.correctAnswer
                            ? Colors.green
                            : Colors.red
                        : Colors.grey.shade700,
                width: 1.5.w,
              ),
              color: widget.optionSelected == ''
                  ? widget.validate
                      ? widget.correctAnswer
                          ? Colors.green
                          : Colors.red
                      : Colors.white
                  : widget.validate
                      ? widget.correctAnswer
                          ? Colors.green
                          : Colors.red
                      : Colors.blueGrey,
              borderRadius: BorderRadius.circular(24.sp),
            ),
            child: Text(
              widget.option,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: widget.optionSelected == widget.answer
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width.w * 0.65,
            child: Text(
              widget.answer,
              style: TextStyle(
                fontSize: 17.sp,
                color: widget.optionSelected == ''
                    ? widget.validate
                        ? widget.correctAnswer
                            ? Colors.green
                            : Colors.red
                        : Colors.white
                    : widget.validate
                        ? widget.correctAnswer
                            ? Colors.green
                            : Colors.red
                        : Colors.grey.shade400,
              ),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
