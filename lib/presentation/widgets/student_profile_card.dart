// lib/presentation/widgets/student_profile_card.dart
import 'package:flutter/material.dart';
import '../../domain/entities/student.dart';

class StudentProfileCard extends StatelessWidget {
  final Student student;

  const StudentProfileCard({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text("${student.name} ${student.lastName}"),
        subtitle: Text("Domain: ${student.domain}\nBatch: ${student.batch}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Navigate to edit screen
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Call delete functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
