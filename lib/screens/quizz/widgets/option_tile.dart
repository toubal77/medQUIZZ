import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String answer, option, optionSelected;
  final bool correctAnswer;
  OptionTile({
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
      height: 45,
      padding: EdgeInsets.only(left: 20, right: 10),
      margin: EdgeInsets.only(top: 3, bottom: 3),
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.optionSelected == widget.answer
                        ? widget.optionSelected == widget.answer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7)
                        : Colors.grey,
                    width: 1.5),
                color: widget.optionSelected == widget.answer
                    ? widget.optionSelected == widget.answer
                        ? Colors.green.withOpacity(0.7)
                        : Colors.red.withOpacity(0.7)
                    : Colors.white,
                borderRadius: BorderRadius.circular(24)),
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
            width: 8,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              widget.answer,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 17,
                color: Colors.blue,
                letterSpacing: 0.36,
              ),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
