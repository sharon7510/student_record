import 'package:student_record/domain/entities/student.dart' as entity;
import 'package:student_record/domain/repositories/student_repository.dart';
import '../datasources/firebase_student_data_source.dart';
import '../models/student_model.dart';

class StudentRepositoryImpl implements StudentRepository {
  final FirebaseStudentDataSource dataSource;

  StudentRepositoryImpl(this.dataSource);

  @override
  Future<void> addStudent(entity.Student student) {
    final studentModel = StudentModel(
      id: student.id,
      name: student.name,
      lastName: student.lastName,
      domain: student.domain,
      hub: student.hub,
      batch: student.batch,
      date: student.date,
      month: student.month,
      gender: student.gender,
    );
    return dataSource.addStudent(studentModel);
  }

  @override
  Future<void> deleteStudent(String id) {
    return dataSource.deleteStudent(id);
  }

  @override
  Stream<List<entity.Student>> getStudents() {
    return dataSource.getStudents().map((studentModels) =>
        studentModels.map((model) => entity.Student(
          id: model.id,
          name: model.name,
          lastName: model.lastName,
          domain: model.domain,
          hub: model.hub,
          batch: model.batch,
          date: model.date,
          month: model.month,
          gender: model.gender,
        )).toList()
    );
  }

  @override
  Future<void> updateStudent(entity.Student student) {
    final studentModel = StudentModel(
      id: student.id,
      name: student.name,
      lastName: student.lastName,
      domain: student.domain,
      hub: student.hub,
      batch: student.batch,
      date: student.date,
      month: student.month,
      gender: student.gender,
    );
    return dataSource.updateStudent(studentModel);
  }
}
