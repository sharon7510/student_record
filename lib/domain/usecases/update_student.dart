import '../entities/student.dart' hide StudentRepository;
import '../repositories/student_repository.dart';

class UpdateStudent {
  final StudentRepository repository;

  UpdateStudent(this.repository);

  Future<void> call(Student student) async {
    await repository.updateStudent(student);
  }
}
