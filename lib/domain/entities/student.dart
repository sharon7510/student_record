// lib/domain/entities/student.dart
class Student {
  final String id;
  final String name;
  final String lastName;
  final String domain;
  final String hub;
  final String batch;
  final String date;
  final String month;
  final String gender;

  Student({
    required this.id,
    required this.name,
    required this.lastName,
    required this.domain,
    required this.hub,
    required this.batch,
    required this.date,
    required this.month,
    required this.gender,
  });
}

abstract class StudentRepository {
  Future<void> addStudent(Student student);
  Future<void> deleteStudent(String id);
  Stream<List<Student>> getStudents();
  Future<void> updateStudent(Student student);
}
