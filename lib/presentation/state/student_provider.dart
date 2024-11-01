import 'package:flutter/material.dart';
import '../../domain/entities/student.dart';
import '../../domain/usecases/add_student.dart';
import '../../domain/usecases/delete_student.dart';
import '../../domain/usecases/update_student.dart';
import '../../domain/usecases/get_students.dart';

class StudentProvider with ChangeNotifier {
  final GetStudents getStudentsUseCase;
  final AddStudent addStudentUseCase;
  final UpdateStudent updateStudentUseCase;
  final DeleteStudent deleteStudentUseCase;

  Stream<List<Student>>? _studentsStream;

  StudentProvider(
      this.getStudentsUseCase,
      this.addStudentUseCase,
      this.updateStudentUseCase,
      this.deleteStudentUseCase,
      ) {
    fetchStudents();
  }

  Stream<List<Student>>? get studentsStream => _studentsStream;

  // Fetch all students
  void fetchStudents() {
    _studentsStream = getStudentsUseCase();
    notifyListeners();
  }

  // Add a new student
  Future<void> addStudent(Student student) async {
    await addStudentUseCase(student);
    fetchStudents(); // Refresh the list
  }

  // Update an existing student
  Future<void> updateStudent(Student student) async {
    await updateStudentUseCase(student);
    fetchStudents(); // Refresh the list
  }

  // Delete a student by ID
  Future<void> deleteStudent(String id) async {
    await deleteStudentUseCase(id);
    fetchStudents(); // Refresh the list
  }
}
