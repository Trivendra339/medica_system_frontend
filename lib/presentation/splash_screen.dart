import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plumedica/helper/AppTextStyles.dart';
import 'package:plumedica/helper/colors.dart';
import 'package:plumedica/helper/sizes.dart';
import 'package:plumedica/presentation/selection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/bd.dart';
import '../data/models/doctor_model.dart';
import 'doctor/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate()async{
    DoctorModel? localDoctor = await SharedPrefService.getDoctor();
    if (localDoctor != null) {
      Timer(Duration(seconds: 3),(){
        Get.offAll(()=> DoctorHomeScreen());
      });
    } else {
      Timer(Duration(seconds: 3),(){
        Get.offAll(()=> SelectionScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
                height: 100,width: 100,color: TAppColors.primaryColor,
                'assets/healthcare.png'),
            SizedBox(height: TAppSizes.md,),
            Text('Plumedica',style:TAppTextStyles.headline3.copyWith(color: TAppColors.primaryColor))
          ],
        ),
      ),
    );
  }
}
