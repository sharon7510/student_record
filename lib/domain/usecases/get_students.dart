import 'package:student_record/domain/entities/student.dart' hide StudentRepository;
import 'package:student_record/domain/repositories/student_repository.dart';


class GetStudents {
  final StudentRepository repository;

  GetStudents(this.repository);

  // Call operator to simplify the use case invocation
  Stream<List<Student>> call() {
    return repository.getStudents();
  }
}
