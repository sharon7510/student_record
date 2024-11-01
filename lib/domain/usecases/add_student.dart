import '../entities/student.dart' hide StudentRepository;
import '../repositories/student_repository.dart';

class AddStudent {
  final StudentRepository repository;

  AddStudent(this.repository);

  Future<void> call(Student student) async {
    return repository.addStudent(student);
  }
}
