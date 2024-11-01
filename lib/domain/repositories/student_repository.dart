// lib/domain/repositories/student_repository.dart
import '../entities/student.dart';

abstract class StudentRepository {
  Future<void> addStudent(Student student);
  Stream<List<Student>> getStudents();
  Future<void> updateStudent(Student student);
  Future<void> deleteStudent(String id);
}
