import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:student_record/presentation/state/student_provider.dart';
import 'data/datasources/firebase_student_data_source.dart';
import 'data/repositories/student_repository_impl.dart';
import 'domain/repositories/student_repository.dart';
import 'domain/usecases/add_student.dart';
import 'domain/usecases/delete_student.dart';
import 'domain/usecases/get_students.dart';
import 'domain/usecases/update_student.dart';
import 'firebase_options.dart';
import 'presentation/screens/student_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseStudentDataSource>(
          create: (_) => FirebaseStudentDataSource(),
        ),
        Provider<StudentRepository>(
          create: (context) => StudentRepositoryImpl(
            context.read<FirebaseStudentDataSource>(),
          ),
        ),
        Provider<AddStudent>(
          create: (context) => AddStudent(context.read<StudentRepository>()),
        ),
        Provider<UpdateStudent>(
          create: (context) => UpdateStudent(context.read<StudentRepository>()),
        ),
        Provider<DeleteStudent>(
          create: (context) => DeleteStudent(context.read<StudentRepository>()),
        ),
        Provider<GetStudents>(
          create: (context) => GetStudents(context.read<StudentRepository>()),
        ),
        ChangeNotifierProvider<StudentProvider>(
          create: (context) => StudentProvider(
            context.read<GetStudents>(),
            context.read<AddStudent>(),
            context.read<UpdateStudent>(),
            context.read<DeleteStudent>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Student Management',
        debugShowCheckedModeBanner: false,
      //   theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   textTheme: const TextTheme(
      //     titleLarge: TextStyle(
      //       fontSize: 20.0,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.blueAccent,
      //     ),
      //     bodyLarge: TextStyle(
      //       fontSize: 16.0,
      //       color: Colors.black87,
      //     ),
      //   ),
      // ),
        home: StudentListScreen(),
      ),
    );
  }
}