import '../repositories/student_repository.dart';

class DeleteStudent {
  final StudentRepository repository;

  DeleteStudent(this.repository);

  Future<void> call(String id) async {
    await repository.deleteStudent(id);
  }
}
