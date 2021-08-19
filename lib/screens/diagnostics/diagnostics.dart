import 'package:flutter/material.dart';
import 'package:med_quizz/models/diagnostics.dart';
import 'package:med_quizz/screens/diagnostics/widgets/diag_tile.dart';
import 'package:med_quizz/screens/diagnostics/widgets/diag_tile_shimmer.dart';
import 'package:med_quizz/screens/diagnostics/widgets/header_diag.dart';
import 'package:med_quizz/services/database.dart';

class Diagnostic extends StatelessWidget {
  const Diagnostic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_page.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              HeaderDiag(title: 'Diagnostics'),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 60),
                child: FutureBuilder<List<Diagnostics?>?>(
                  future: DatabaseMethods().getDiag(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        //    physics: NeverScrollableScrollPhysics(),

                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return DiagTile(snapshot.data![index]!);
                        },
                      );
                    }
                    return DiagTileShimmer();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
