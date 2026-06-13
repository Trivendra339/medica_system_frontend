import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plumedica/data/doctor_model.dart';
import 'package:plumedica/helper/sizes.dart';
import 'package:plumedica/presentation/supar_admin/controller/supar_admin_cont.dart';
import 'package:plumedica/presentation/widget/doctor_detail.dart';
import 'package:plumedica/presentation/widget/round_button.dart';
import 'package:uuid/uuid.dart';
import '../../../helper/validation.dart';

class DoctorDetailsScreen extends StatelessWidget {
  DoctorModel? doctor;
   DoctorDetailsScreen({super.key,this.doctor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Details"),
        elevation: 0.5,
      ),
      body: GetBuilder<SuperAdminCont>(builder: (controller){
        DoctorModel? currentDoctor = controller.approve ?? doctor;
        if (currentDoctor == null) {
          return const Center(
            child: Text(
              "No Doctor Details Available",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return DoctorDetailWidget(
          doctor: currentDoctor,
          widget: ApproveRejection(doctorName: currentDoctor.name, id: currentDoctor.id)
        );
      }),
    );
  }
}

class ApproveRejection extends StatelessWidget {
  ApproveRejection({super.key, required this.doctorName, required this.id});

  final cont = SuperAdminCont.instance;
  final String doctorName;
  final int id;
  static const uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Obx(
          ()=> TRoundButtonFiled(
                isLoading: cont.isLoading.value,
                buttonText: 'Approved',
                onPress: () {
                  cont.doctorIdController.text = uuid.v4();
                  openDialog(title: 'Approved', middleText: doctorName, onTap: (){
                    cont.getApprove(id: id, doctorId: cont.doctorIdController.text.trim());
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: TAppSizes.spaceBtwItems),

          Expanded(
            child: Obx(
              ()=> TRoundButtonFiled(
                isLoading: cont.isLoading.value,
                buttonText: 'Rejected',
                onPress: () {
                  openDialog(title: 'Rejected', middleText: doctorName, onTap: (){
                    cont.getReject(id: id,reason: cont.reasonController.text.trim());
                  });

                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openDialog({
    required String title,
    required String middleText,
    required VoidCallback onTap,
  }) {
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
              controller: cont.doctorIdController,
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

        return TRoundButtonFiled(
          isLoading: title == "Approved" ? cont.approvedLoading.value : cont.rejectedLoading.value,
          buttonText: 'Confirm',
          onPress: () {
            if (dialogFormKey.currentState!.validate()) {
              onTap();
            }
          },
        );
      }),

      cancel: TextButton(
        onPressed: (){
          cont.doctorIdController.clear();
          cont.reasonController.clear();
          Get.back();
        },
        child: const Text('Cancel', style: TextStyle(color: Colors.red)),
      ),
    );
  }
}
