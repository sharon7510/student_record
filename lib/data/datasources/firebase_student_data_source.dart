import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student_model.dart';

class FirebaseStudentDataSource {
  final CollectionReference studentsCollection =
  FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(StudentModel student) {
    return studentsCollection.add(student.toMap());
  }

  Future<void> deleteStudent(String id) {
    return studentsCollection.doc(id).delete();
  }

  Stream<List<StudentModel>> getStudents() {
    return studentsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return StudentModel.fromMap(data, doc.id);
      }).toList();
    });
  }

  Future<void> updateStudent(StudentModel student) {
    return studentsCollection.doc(student.id).update(student.toMap());
  }
}
