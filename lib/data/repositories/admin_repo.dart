import '../../helper/api/api.dart';
import '../../helper/api/api_service.dart';
import '../models/doctor_model.dart';

class AdminRepo {
  final ApiService _apiService = ApiService();

  Future<List<DoctorModel>> repoDoctorsList()async {
    try{
      List<dynamic> apiResponse = await _apiService.get(url: ApiUrls.getDoctors);
      return List<DoctorModel>.from(apiResponse.map((e)=> DoctorModel.fromJson(e)));
    } catch(e){
      rethrow;
    }
  }

  Future<DoctorModel> repoDoctorsApprove(int id,Map doctorId)async {
    try{
      Map<String,dynamic> apiResponse = await _apiService.put(url: ApiUrls.approve(id),body: doctorId);
      return DoctorModel.fromJson(apiResponse);
    } catch(e){
      rethrow;
    }
  }

  Future<DoctorModel> repoDoctorsReject(int id,Map reason)async {
    try{
      Map<String,dynamic> apiResponse = await _apiService.put(url: ApiUrls.reject(id),body: reason);
      return DoctorModel.fromJson(apiResponse);
    } catch(e){
      rethrow;
    }
  }
}