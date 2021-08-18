import 'package:flutter/material.dart';
import 'package:med_quizz/models/diagnostics.dart';
import 'package:med_quizz/screens/diagnostics/detail_Diag/detail_diag.dart';

class DiagTile extends StatelessWidget {
  final Diagnostics diag;
  DiagTile(this.diag);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailDiag(diag);
            },
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 310,
        margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
        // padding: const EdgeInsets.symmetric(vertical: 130),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black45.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0.7, 0.7),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://rayanzinotblans.000webhostapp.com/images/diagnostics/' +
                            diag.image.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diag.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      diag.description,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ), // ReadMoreText(
                    //   'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    //   trimLines: 3,
                    //   trimLength: 500,
                    //   colorClickableText: Colors.pink,
                    //   trimMode: TrimMode.Length,
                    //   trimCollapsedText: 'Show more',
                    //   trimExpandedText: 'Show less',
                    //   moreStyle: TextStyle(
                    //       fontSize: 13, fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
