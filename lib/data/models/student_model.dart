import '../../domain/entities/student.dart';

class StudentModel extends Student {
  StudentModel({
    required String id,
    required String name,
    required String lastName,
    required String domain,
    required String hub,
    required String batch,
    required String date,
    required String month,
    required String gender,
  }) : super(
    id: id,
    name: name,
    lastName: lastName,
    domain: domain,
    hub: hub,
    batch: batch,
    date: date,
    month: month,
    gender: gender,
  );

  // Convert Firestore document data to a StudentModel
  factory StudentModel.fromMap(Map<String, dynamic> data, String documentId) {
    return StudentModel(
      id: documentId,
      name: data['name'] ?? '',
      lastName: data['last_name'] ?? '',
      domain: data['domain'] ?? '',
      hub: data['hub'] ?? '',
      batch: data['batch'] ?? '',
      date: data['date'] ?? '',
      month: data['month'] ?? '',
      gender: data['gender'] ?? '',
    );
  }

  // Convert StudentModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'last_name': lastName,
      'domain': domain,
      'hub': hub,
      'batch': batch,
      'date': date,
      'month': month,
      'gender': gender,
    };
  }
}
