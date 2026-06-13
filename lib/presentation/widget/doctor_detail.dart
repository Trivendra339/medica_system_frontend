import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plumedica/presentation/widget/round_button.dart';
import 'package:uuid/uuid.dart';

import '../../data/doctor_model.dart';
import '../../helper/sizes.dart';
import '../supar_admin/controller/supar_admin_cont.dart';



class DoctorDetailWidget extends StatelessWidget {
  final bool? isDoctor;
  final DoctorModel doctor;
  final SuperAdminCont? cont;
  final Function(String title, String middleText, VoidCallback onTap)? openDialog;

  const DoctorDetailWidget({
    super.key,
    this.isDoctor = false,
    required this.doctor,
    this.cont,
    this.openDialog,
  });

  @override
  Widget build(BuildContext context) {
    const uuid = Uuid();

    return ListView(
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

        // _item("Name", doctor?.name),
        // _item("Email", doctor?.email),
        // _item("Status", doctor?.status),
        // _item("Mobile", doctor?.mobile),
        // _item("Qualification", doctor?.qualification),
        // _item("Experience", "${doctor?.experience} Years"),
        // _item("Clinic Name", doctor?.hcName),
        // _item("Address", doctor?.hcAddress),
        // _item("License No.", doctor?.licenseNumber),
        // _item("doctorId", doctor?.doctorId),
        // _item("rejectionReason", doctor?.rejectionReason),
        // _item("Availability Days", doctor?.availabilityDays),
        // _item("Availability Time", doctor?.availabilityTime),
        // _item("Created At", doctor?.createdAt),

        _item("Name", doctor.name),
        _item("Email", doctor.email),
        _item("Status", doctor.status),
        _item("Mobile", doctor.mobile),
        _item("Qualification", doctor.qualification),
        _item("Experience", "${doctor.experience} Years"),
        _item("Clinic Name", doctor.hcName),
        _item("Address", doctor.hcAddress),
        _item("License No.", doctor.licenseNumber),
        _item("doctorId", doctor.doctorId),
        _item("rejectionReason", doctor.rejectionReason),
        _item("Availability Days", doctor.availabilityDays),
        _item("Availability Time", doctor.availabilityTime),
        _item("Created At", doctor.createdAt),


        if(isDoctor != true)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(() => Row(
              children: [
                // Approved Button
                Expanded(
                  child: TRoundButtonFiled(
                    isLoading: cont!.isLoading.value,
                    buttonText: 'Approved',
                    onPress: () {
                      cont?.doctorIdController.text = uuid.v4();

                      openDialog?.call(
                        "Approved",
                        doctor!.name,
                            () {
                          cont?.getApprove(
                            id: doctor!.id,
                            doctorId: cont!.doctorIdController.text,
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: TAppSizes.spaceBtwItems),

                // Rejected Button
                Expanded(
                  child: TRoundButtonFiled(
                    isLoading: cont!.isLoading.value,
                    buttonText: 'Rejected',
                    onPress: () {
                      cont?.doctorIdController.clear();
                      openDialog?.call(
                        "Rejected",
                        doctor!.name,
                            () {
                          cont?.getReject(
                            id: doctor!.id,
                            reason: cont!.doctorIdController.text,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            )),
          )
      ],
    );
  }

  Widget _item(String? title, String? value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          title: Text(
            title??'',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          subtitle: Text(
            (value == null || value.isEmpty) ? "N/A" : value,
            style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
      ],
    );
  }
}