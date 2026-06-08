import 'package:plumedica/data/doctor_model.dart';
import 'package:plumedica/data/register_model.dart';
import 'package:plumedica/helper/api.dart';
import 'package:dio/dio.dart';
import '../../helper/api_service.dart';

class DoctorRepo {
  final ApiService _apiService = ApiService();

  Future<DoctorModel> repoLogin(Object body) async {
    try {
      Map<String, dynamic> apiResponse = await _apiService.post(
        url: ApiUrls.login,
        body: body,
      );
      return DoctorModel.fromJson(apiResponse);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> repoFileUpload(FormData formData) async {
    try {
      final apiResponse = await _apiService.post(
        url: ApiUrls.uploadFile,
        body: formData,
      );

      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> repoRegister(RegisterModel body) async {
    try {
      Map<String, dynamic> apiResponse = await _apiService.post(
        url: ApiUrls.register,
        body: body,
      );
      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }
}
