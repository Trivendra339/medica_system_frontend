import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:plumedica/helper/AppTextStyles.dart';
import 'package:plumedica/presentation/supar_admin/controller/supar_admin_cont.dart';
import 'package:plumedica/presentation/supar_admin/screens/detail_screen.dart';
import 'package:plumedica/presentation/widget/dashboard_header.dart';
import 'package:plumedica/presentation/widget/padding.dart';
import 'package:plumedica/presentation/widget/round_button.dart';

import '../../../data/doctor_model.dart';
import '../../../helper/colors.dart';
import '../../../helper/sizes.dart';

class SuperAdminDashboardScreen extends StatefulWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  State<SuperAdminDashboardScreen> createState() => _SuperAdminDashboardScreenState();
}

class _SuperAdminDashboardScreenState extends State<SuperAdminDashboardScreen> {

  final controller = Get.put(SuperAdminCont());
  @override
  void initState() {
    super.initState();
    SuperAdminCont.instance.getDoctors();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: TAppPadding.screenPadding,
          child: Column(
            children: [
              TDashboardHeader(
                greeting: 'Welcome Back',
                title: 'Super Admin',
                subtitle: 'Manage Doctors Efficiently',
              ),


              const SizedBox(height: TAppSizes.spaceBtwSections),

              TextField(
                onChanged: (value) => controller.filterBySearch(value),
                decoration: InputDecoration(
                  hintText: 'Search Doctor',
                  prefixIcon: const Icon(Icons.search, color: TAppColors.primaryColor),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TAppSizes.inputFieldRadius),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: TAppSizes.spaceBtwItems),

              DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: "Status"),
                  items: const [
                    DropdownMenuItem(value: "All", child: Text("All")),
                    DropdownMenuItem(value: "Pending", child: Text("Pending")),
                    DropdownMenuItem(value: "Approved", child: Text("Approved")),
                    DropdownMenuItem(value: "Rejected", child: Text("Rejected")),
                  ],
                  onChanged: (value)=>controller.filterByStatus(value!)
              ),

              const SizedBox(height: TAppSizes.spaceBtwSections),

              Obx((){
                if(controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator(),);
                }

                if (controller.filteredDoctorsList.isEmpty) {
                  return Center(child: Text("No Doctor Available",style: TAppTextStyles.headline4));
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.filteredDoctorsList.length,
                  separatorBuilder: (_, _) =>
                  const SizedBox(height: TAppSizes.spaceBtwItems),
                  itemBuilder: (_, index){
                    final DoctorModel doctor = controller.filteredDoctorsList[index];
                    return ListTile(
                      onTap: ()=>Get.to(DoctorDetailsScreen(doctor: doctor)),
                      tileColor: TAppColors.primaryColor.withValues(alpha: 0.02),
                      leading: CircleAvatar(child: Text(doctor.name[0])),
                      title: Text("Dr. ${doctor.name}"),
                      // subtitle: Text("ID: ${doctor.doctorId}"),
                      subtitle: Text("Address: ${doctor.hcAddress}"),
                      trailing: Chip(
                        label: Text(doctor.status),
                        backgroundColor: doctor.status == 'APPROVED' ? TAppColors.primaryColor.withValues(alpha: .1) : TAppColors.secondaryColor.withValues(alpha: .1),
                      ),
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}


