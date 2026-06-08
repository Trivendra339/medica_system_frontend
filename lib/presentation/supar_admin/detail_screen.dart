import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plumedica/data/doctor_model.dart';
import 'package:plumedica/helper/sizes.dart';
import 'package:plumedica/presentation/supar_admin/controller/supar_admin_cont.dart';
import 'package:plumedica/presentation/widget/doctor_detail.dart';
import 'package:plumedica/presentation/widget/round_button.dart';
import 'package:uuid/uuid.dart';

import '../../helper/validation.dart';

class DoctorDetailsScreen extends StatelessWidget {
  DoctorModel? doctor;
   DoctorDetailsScreen({super.key,this.doctor});

  final _uuid = const Uuid();
  @override
  Widget build(BuildContext context) {
    final cont = SuperAdminCont.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Details"),
        elevation: 0.5,
      ),
      body: GetBuilder<SuperAdminCont>(builder: (controller){
        final currentDoctor = controller.approve ?? doctor;
        if (currentDoctor == null) {
          return const Center(
            child: Text(
              "No Doctor Details Available",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return DoctorDetailWidget(
          doctor: currentDoctor!,
          cont: controller,
          openDialog: (title, middleText, onTap) {
            openDialog(title: title, middleText: middleText, onTap: onTap);
          },
        );
      }),
    );
  }
  /*
          return DoctorDetailWidget(
          doctor: doctor!,
          cont: controller,
          openDialog: (title, middleText, onTap) {
            openDialog(title: title, middleText: middleText, onTap: onTap);
          },
        );
   */

  /*
  ListView(
        children: [
          const SizedBox(height: TAppSizes.xl),


          const Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person, color: Colors.white, size: 40),
            ),
          ),
          const SizedBox(height: TAppSizes.xl),

          _item("Name", doctor?.name),
          _item("Email", doctor?.email),
          _item("status", doctor?.status),
          _item("Mobile", doctor?.mobile),
          _item("Qualification", doctor?.qualification),
          _item("Experience", doctor?.experience.toString()),
          _item("Clinic Name", doctor?.hcName),
          _item("Address", doctor?.hcAddress),
          _item("License No.", doctor?.licenseNumber),
          _item("AvailabilityDays", doctor?.availabilityDays),
          _item("AvailabilityTime", doctor?.availabilityTime),
          _item("createdAt", doctor?.createdAt),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TRoundButtonFiled(
                    isLoading: cont.isLoading.value,
                    buttonText: 'Approved',
                    onPress: () {
                      cont.doctorIdController.text = _uuid.v4();

                      openDialog(
                        title: "Approved",
                        middleText: doctor?.name??'',
                        onTap: () {
                          cont.getApprove(
                            id: doctor?.id??0,
                            doctorId: cont.doctorIdController.text,
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(width: TAppSizes.spaceBtwItems),
                Expanded(
                  child: TRoundButtonFiled(
                    isLoading: cont.isLoading.value,
                    buttonText: 'Rejected',
                    onPress: () {
                      cont.doctorIdController.clear();
                      openDialog(
                        title: "Rejected",
                        middleText: doctor?.name??'',
                        onTap: () {
                          cont.getReject(
                            id: doctor?.id??0,
                            reason: cont.doctorIdController.text,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      )
   */

  Widget _item(String? title, String? value) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title ??'',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          subtitle: Text(
            value??'',
            style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        const Divider(indent: 16, endIndent: 16, height: 1), // Patli line niche
      ],
    );
  }

  void openDialog({
    required String title,
    required String middleText,
    required VoidCallback onTap,
  }) {
    final controller = SuperAdminCont.instance;
    final dialogFormKey = GlobalKey<FormState>();

    Get.defaultDialog(
      title: title,
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      middleTextStyle: const TextStyle(color: Colors.grey),

      content: Form(
        key: dialogFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(middleText),
            SizedBox(height: TAppSizes.spaceBtwItems),
            TextFormField(
              controller: controller.doctorIdController,
              validator: (value) => TAppValidator.validateEmptyText(
                  title == "Approved" ? "Doctor ID" : "Reason",
                  value
              ),
              decoration: InputDecoration(
                label: Text(title == "Approved" ? "Doctor ID" : "Reason"),
                prefixIcon: title == "Approved" ? const Icon(Icons.approval) : const Icon(Icons.remove_circle_outline),
              ),
            ),
          ],
        ),
      ),

      confirm: Obx(() {
        final bool isBtnLoading = title == "Approved"
            ? controller.approvedLoading.value
            : controller.rejectedLoading.value;

        return TRoundButtonFiled(
          isLoading: isBtnLoading,
          buttonText: 'Confirm',
          onPress: () {
            if (dialogFormKey.currentState!.validate()) {
              onTap();
            }
          },
        );
      }),

      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel', style: TextStyle(color: Colors.red)),
      ),
    );
  }
}