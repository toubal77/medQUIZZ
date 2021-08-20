import 'package:flutter/material.dart';
import 'package:med_quizz/models/modules.dart';
import 'package:med_quizz/screens/all_module/widgets/module_tile.dart';
import 'package:med_quizz/screens/all_module/widgets/shimmer_module_tile.dart';
import 'package:med_quizz/screens/home_screen.dart';
import 'package:med_quizz/screens/search/search_screen.dart';
import 'package:med_quizz/services/database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllModules extends StatelessWidget {
  const AllModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_page.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 10.sp, left: 10.sp, right: 10.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return HomePage();
                                  },
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_back),
                            color: Colors.blue,
                          ),
                          Text(
                            'All Modules',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SearchScreen();
                                  },
                                ),
                              );
                            },
                            icon: Icon(Icons.search),
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Modules?>?>(
                  future: DatabaseMethods().getModules(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ModuleTile(snapshot.data![index]!);
                        },
                      );
                    }
                    return ModuleTileShimmer();
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
