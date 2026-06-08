import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plumedica/data/doctor_model.dart';
import 'package:plumedica/data/register_model.dart';
import 'package:plumedica/data/repositories/doctor_repo.dart';
import 'package:plumedica/presentation/auth/login_screen.dart';
import 'package:plumedica/presentation/doctor/screen/home_screen.dart';
import 'package:plumedica/presentation/selection_screen.dart';

import '../../../data/bd.dart';
import '../../widget/snackbar_helpers.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final DoctorRepo _doctorRepo = DoctorRepo();

  // final localStorage = GetStorage();

  RxBool isLoadingFile = false.obs;

  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = true.obs;

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final rememberMe = false.obs;

  final picker = ImagePicker();
  File? image;

  final doctor = Rx<DoctorModel?>(null);
  RxMap<dynamic, dynamic>  documentPath = {}.obs;

  final emailCont = TextEditingController();
  final passwordCont = TextEditingController();

  final name = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  final qualification = TextEditingController();
  final hcName = TextEditingController();
  final address = TextEditingController();
  final phoneNo = TextEditingController();
  final licenseNumber = TextEditingController();
  final experience = TextEditingController();
  final availabilityDays = TextEditingController();
  final availabilityTime = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();


  @override
  void onInit() {
    availabilityDays.text = "Mon - Sat";
    availabilityTime.text = "9:00 am - 5:00 pm";
    loadLocalDoctorData();
  }

  Future<void> loadLocalDoctorData() async {
    DoctorModel? localDoctor = await SharedPrefService.getDoctor();
    if (localDoctor != null) {
      doctor.value = localDoctor;
    }
  }
  Future removeLocalDoctorData() async {
    await SharedPrefService.removeDoctor();
    Get.to(SelectionScreen());
    return;
  }


  Future<void> login() async {

    try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        'email': emailCont.text.trim(),
        'password': passwordCont.text.trim(),
      };

      final response = await _doctorRepo.repoLogin(data);
      doctor.value = response;
      await SharedPrefService.saveDoctor(doctor.value!);
      clearAllControllers();
      isLoading.value = false;
      Get.offAll(() => DoctorHomeScreen());
      return;
    } catch (e) {
      TAppSnackBarHelpers.errorSnackBar(title: e.toString());
      isLoading.value = false;
    }finally{
      isLoading.value = false;
      clearAllControllers();
    }
  }

  Future<void> register() async {
    try {

      if(password.text.toString() != confirmPassword.text.toString()) {
        Get.snackbar("Error", "Password not match");
        return;
      }
      isLoading.value = true;
      RegisterModel data = RegisterModel(
        name: name.text.trim(),
        email: email.text.trim(),
        mobile: mobile.text.trim(),
        hashedPassword: password.text.trim(),
        qualification: qualification.text.trim(),
        experience: int.parse(experience.text.trim()),
        hCAddress: address.text.trim(),
        hCName: hcName.text.trim(),
        licenseNumber: licenseNumber.text.trim(),
        availabilityDays: availabilityDays.text.trim(),
        availabilityTime: availabilityTime.text.trim(),
        documentPath: documentPath.value['file_path'],
      );

      final responseData = await _doctorRepo.repoRegister(data);
      Map<String, dynamic> response = responseData;
      documentPath.clear();
      clearAllControllers();
      Get.offAll(LoginScreen(role: 'doctor', roleTitle: "Doctor"));
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      TAppSnackBarHelpers.errorSnackBar(title: e.toString());
    } finally {
      clearAllControllers();
      isLoading.value = false;
    }
  }

  Future<void> uploadFile() async {
    try {
      isLoadingFile.value = true;
      XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (pickedFile?.path == null) {
        isLoadingFile.value = false;
        return;
      }

      image = File(pickedFile!.path);

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          image!.path,
          filename: image!.path.split('/').last,
        ),
      });

      final response =
      await _doctorRepo.repoFileUpload(formData);
      documentPath.value = response;

      isLoadingFile.value = false;
    } catch (e) {

      TAppSnackBarHelpers.errorSnackBar(title: e.toString());
      isLoadingFile.value = false;
    }
  }

  void clearAllControllers() {
    emailCont.clear();
    passwordCont.clear();

    name.clear();
    email.clear();
    mobile.clear();
    qualification.clear();
    hcName.clear();
    address.clear();
    phoneNo.clear();
    licenseNumber.clear();
    experience.clear();
    password.clear();
    confirmPassword.clear();
  }
}
