import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/models/modules.dart';
import 'package:med_quizz/screens/all_module/module_screen.dart';

class ModuleTile extends StatelessWidget {
  final Modules mod;
  const ModuleTile(this.mod);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ModuleScreen(mod.nom);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Container(
          width: 315.w,
          height: 220.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            image: DecorationImage(
              image: NetworkImage(
                'https://rayanzinotblans.000webhostapp.com/images/${mod.image}',
              ),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.sp, 2.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
