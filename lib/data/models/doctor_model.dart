class DoctorModel {
  final int id;
  final String doctorId;
  final String name;
  final String email;
  final String mobile;
  final String qualification;
  final int experience;
  final String hcName;
  final String hcAddress;
  final String licenseNumber;
  final String availabilityDays;
  final String availabilityTime;
  final String documentPath;
  final String status;
  final String? rejectionReason;
  final String createdAt;
  final String updatedAt;


  DoctorModel({
    required this.id,
    required this.doctorId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.qualification,
    required this.experience,
    required this.hcName,
    required this.hcAddress,
    required this.licenseNumber,
    required this.availabilityDays,
    required this.availabilityTime,
    required this.documentPath,
    required this.status,
    this.rejectionReason,
    required this.createdAt,
    required this.updatedAt,
  });


  factory DoctorModel.empty() => DoctorModel(
    id: 0,
    doctorId: '',
    name: '',
    email: '',
    mobile: '',
    qualification: '',
    experience: 0,
    hcName: '',
    hcAddress: '',
    licenseNumber: '',
    availabilityDays: '',
    availabilityTime: '',
    documentPath: '',
    status: 'PENDING',
    rejectionReason: null,
    createdAt: '',
    updatedAt: '',
  );


  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? 0,
      doctorId: json['doctor_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      qualification: json['qualification'] ?? '',
      experience: int.tryParse(json['experience'].toString()) ?? 0,
      hcName: json['h_c_name'] ?? '',
      hcAddress: json['h_c_address'] ?? '',
      licenseNumber: json['license_number'] ?? '',
      availabilityDays: json['availability_days'] ?? '',
      availabilityTime: json['availability_time'] ?? '',
      documentPath: json['document_path'] ?? '',
      status: json['status'] ?? 'PENDING',
      rejectionReason: json['rejection_reason'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'name': name,
      'email': email,
      'mobile': mobile,
      'qualification': qualification,
      'experience': experience,
      'h_c_name': hcName,
      'h_c_address': hcAddress,
      'license_number': licenseNumber,
      'availability_days': availabilityDays,
      'availability_time': availabilityTime,
      'document_path': documentPath,
      'status': status,
      'rejection_reason': rejectionReason,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}