import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plumedica/helper/AppTextStyles.dart';
import 'package:plumedica/presentation/selection_screen.dart';
import 'package:plumedica/presentation/splash_screen.dart';
import 'package:plumedica/presentation/widget/text_form_field.dart';
import 'helper/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plumedica',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarThemeData(iconTheme: IconThemeData(color: TAppColors.whiteColor),backgroundColor: TAppColors.primaryColor,titleTextStyle: TAppTextStyles.headline3.copyWith(color: TAppColors.whiteColor)),
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: .fromSeed(seedColor: Colors.blue),
        inputDecorationTheme: AppThemeData.inputDecorationTheme,
        elevatedButtonTheme: AppThemeData.elevatedButtonTheme
      ),
      home: const SplashScreen(),
    );
  }
}

