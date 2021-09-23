import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class BuildCardScore extends StatelessWidget {
  final dynamic score;
  final bool show;
  const BuildCardScore(this.score, this.show);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.sp),
      ),
      child: ListTile(
        title: Text(
          !show
              ? int.parse(score['correct'].toString()) <= 5
                  ? 'insuffisant'
                  : int.parse(score['correct'].toString()) <= 7
                      ? 'acceptable'
                      : 'excellent'
              : score['module'].toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          !show
              ? timeago.format(
                  DateTime.parse(
                    score['time'].toString(),
                  ),
                )
              : int.parse(score['correct'].toString()) <= 5
                  ? 'insuffisant'
                  : int.parse(score['correct'].toString()) <= 7
                      ? 'acceptable'
                      : 'excellent',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        trailing: Text(
          "${score['correct']}/10",
          style: TextStyle(
            color: int.parse(score['correct'].toString()) <= 5
                ? Colors.red
                : int.parse(score['correct'].toString()) <= 7
                    ? Colors.orange
                    : Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
