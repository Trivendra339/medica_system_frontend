import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:plumedica/data/doctor_model.dart';
import 'package:plumedica/data/repositories/admin_repo.dart';
import 'package:plumedica/helper/api.dart';
import 'package:plumedica/presentation/supar_admin/supar_admin_home.dart';
import 'package:plumedica/presentation/widget/snackbar_helpers.dart';
import '../../../helper/api_service.dart';

class SuperAdminCont extends GetxController {
  static SuperAdminCont get instance => Get.find();


  final AdminRepo _adminRepo = AdminRepo();
  RxBool isLoading = false.obs;
  RxBool approvedLoading = false.obs;
  RxBool rejectedLoading = false.obs;

  // List<DoctorModel>? _doctorsList;
  // List<DoctorModel>? get doctorsList => _doctorsList;

  final List<DoctorModel> doctorsList = <DoctorModel>[];
  final RxList<DoctorModel> filteredDoctorsList = <DoctorModel>[].obs;


  var searchQuery = ''.obs;
  var selectedStatus = ''.obs;

  final doctorIdController = TextEditingController();
  final reasonController = TextEditingController();

  DoctorModel? _approve;
  DoctorModel? get approve => _approve;


  Future<void> getDoctors() async {
    try {
      isLoading.value = true;
      final response = await _adminRepo.repoDoctorsList();
      doctorsList.addAll(response);
        filteredDoctorsList.assignAll(doctorsList);
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      TAppSnackBarHelpers.errorSnackBar(title: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getApprove({required int id, required String doctorId}) async {
    try {
      approvedLoading.value = true;
      final response = await _adminRepo.repoDoctorsApprove(id, {"doctor_id":doctorId});
      _approve = response;
      update();
      TAppSnackBarHelpers.successSnackBar(title: "approve");
      print(_approve);
    } catch (e) {
      TAppSnackBarHelpers.errorSnackBar(title: e.toString());
    } finally {
      Get.back();
      approvedLoading.value = false;
    }
  }

  Future<void> getReject({required int id, required String reason}) async {
    try {
      rejectedLoading.value = true;
      final response = await _adminRepo.repoDoctorsReject(id, {"reason":reason});
      TAppSnackBarHelpers.successSnackBar(title: response.toString());
    } catch (e) {
      TAppSnackBarHelpers.errorSnackBar(title: e.toString());
    } finally {
      Get.back();
      rejectedLoading.value = false;
    }
  }

  void filterBySearch(String value) {
    searchQuery.value = value.trim();
    _applyFilter();
  }

  void filterByStatus(String status) {
    if (status.trim().toLowerCase() == "all") {
      selectedStatus.value = '';
    } else {
      selectedStatus.value = status.trim();
    }

    _applyFilter();
  }

  void _applyFilter() {
    final searchLower = searchQuery.value.toLowerCase();
    final statusLower = selectedStatus.value.toLowerCase();

    if (searchLower.isEmpty && statusLower.isEmpty) {
      filteredDoctorsList.assignAll(doctorsList);
      return;
    }

    var result = doctorsList.where((doctor) {
      bool matchesSearch = searchLower.isEmpty ||
          doctor.name.toLowerCase().contains(searchLower) ||
          doctor.doctorId.toLowerCase().contains(searchLower);

      bool matchesStatus = statusLower.isEmpty || doctor.status.toLowerCase() == statusLower;

      return matchesSearch && matchesStatus;
    }).toList();
    filteredDoctorsList.assignAll(result);
  }

}
