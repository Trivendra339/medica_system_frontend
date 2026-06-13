class RegisterModel {
  String? name;
  String? email;
  String? mobile;
  String? hashedPassword;
  String? qualification;
  int? experience;
  String? hCAddress;
  String? hCName;
  String? licenseNumber;
  String? availabilityDays;
  String? availabilityTime;
  String? documentPath;

  RegisterModel(
      {this.name,
        this.email,
        this.mobile,
        this.hashedPassword,
        this.qualification,
        this.experience,
        this.hCAddress,
        this.hCName,
        this.licenseNumber,
        this.availabilityDays,
        this.availabilityTime,
        this.documentPath});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    hashedPassword = json['hashed_password'];
    qualification = json['qualification'];
    experience = json['experience'];
    hCAddress = json['h_c_address'];
    hCName = json['h_c_name'];
    licenseNumber = json['license_number'];
    availabilityDays = json['availability_days'];
    availabilityTime = json['availability_time'];
    documentPath = json['document_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['hashed_password'] = this.hashedPassword;
    data['qualification'] = this.qualification;
    data['experience'] = this.experience;
    data['h_c_address'] = this.hCAddress;
    data['h_c_name'] = this.hCName;
    data['license_number'] = this.licenseNumber;
    data['availability_days'] = this.availabilityDays;
    data['availability_time'] = this.availabilityTime;
    data['document_path'] = this.documentPath;
    return data;
  }
}
