import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/doctor_model.dart';

class SharedPrefService {
  static const String _doctorKey = 'saved_doctor_data';

  static Future<bool> saveDoctor(DoctorModel doctor) async {
    final prefs = await SharedPreferences.getInstance();

    String jsonString = jsonEncode(doctor.toJson());

    return await prefs.setString(_doctorKey, jsonString);
  }

  static Future<DoctorModel?> getDoctor() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_doctorKey);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return DoctorModel.fromJson(jsonMap);
  }

  static Future<bool> removeDoctor() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_doctorKey);
  }
}