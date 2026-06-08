import 'package:flutter/material.dart';
import 'package:get/get.dart'; //
import 'package:plumedica/presentation/auth/controller/login_controller.dart';
import 'package:plumedica/presentation/widget/dashboard_header.dart';
import 'package:plumedica/presentation/widget/doctor_detail.dart';
import 'package:plumedica/presentation/widget/padding.dart';

import '../../../data/bd.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => controller.removeLocalDoctorData(),
            icon: const Icon(Icons.login_outlined),
          )
        ],
      ),
      body: Obx(() {
        final currentDoctor = controller.doctor.value;

        if (currentDoctor == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: TAppPadding.screenPadding,
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: TDashboardHeader(
                  greeting: 'Welcome',
                  title: currentDoctor.name,
                  subtitle: currentDoctor.doctorId,
                ),
              ),
              Expanded(
                child: DoctorDetailWidget(
                  doctor: currentDoctor,
                  isDoctor: true,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}