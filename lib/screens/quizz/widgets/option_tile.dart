import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionTile extends StatefulWidget {
  final String answer;
  final String option;
  final String optionSelected;
  final bool correctAnswer;
  const OptionTile({
    required this.option,
    required this.correctAnswer,
    required this.answer,
    required this.optionSelected,
  });

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
                    color: widget.optionSelected == widget.answer
                        ? widget.optionSelected == widget.answer
                            ? Colors.green.withOpacity(0.7.sp)
                            : Colors.red.withOpacity(0.7.sp)
                        : Colors.grey,
                    width: 1.5.w),
                color: widget.optionSelected == widget.answer
                    ? widget.optionSelected == widget.answer
                        ? Colors.green.withOpacity(0.7.sp)
                        : Colors.red.withOpacity(0.7.sp)
                    : Colors.white,
                borderRadius: BorderRadius.circular(24.sp)),
            child: Text(
              widget.option,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: widget.optionSelected == widget.answer
                    ? Colors.white
                    : Colors.grey,
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
                color: Colors.blue,
              ),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
