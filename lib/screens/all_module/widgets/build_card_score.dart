import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class BuildCardScore extends StatelessWidget {
  final score;
  BuildCardScore(this.score);
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
          score['correct'] <= 5
              ? 'insuffisant'
              : score['correct'] <= 7
                  ? 'acceptable'
                  : 'excellent',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          timeago.format(
            DateTime.parse(
              score['time'].toString(),
            ),
          ),
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        trailing: Text(
          "${score['correct']}/10",
          style: TextStyle(
            color: score['correct'] <= 5
                ? Colors.red
                : score['correct'] <= 7
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
