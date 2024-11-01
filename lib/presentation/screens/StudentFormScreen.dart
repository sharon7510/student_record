import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/student.dart';
import '../state/student_provider.dart';

class StudentFormScreen extends StatefulWidget {
  final Student? student;

  const StudentFormScreen({Key? key, this.student}) : super(key: key);

  @override
  _StudentFormScreenState createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers for each field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController domainController = TextEditingController();
  final TextEditingController hubController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      // If editing, pre-fill form with existing student data
      nameController.text = widget.student!.name;
      lastNameController.text = widget.student!.lastName;
      domainController.text = widget.student!.domain;
      hubController.text = widget.student!.hub;
      batchController.text = widget.student!.batch;
      dateController.text = widget.student!.date;
      monthController.text = widget.student!.month;
      genderController.text = widget.student!.gender;
    }
  }

  @override
  void dispose() {
    // Dispose controllers when screen is disposed
    nameController.dispose();
    lastNameController.dispose();
    domainController.dispose();
    hubController.dispose();
    batchController.dispose();
    dateController.dispose();
    monthController.dispose();
    genderController.dispose();
    super.dispose();
  }

  Future<void> _saveStudent() async {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        id: widget.student?.id ?? '',
        name: nameController.text,
        lastName: lastNameController.text,
        domain: domainController.text,
        hub: hubController.text,
        batch: batchController.text,
        date: dateController.text,
        month: monthController.text,
        gender: genderController.text,
      );

      final studentProvider = Provider.of<StudentProvider>(context, listen: false);
      if (widget.student == null) {
        // Adding a new student
        await studentProvider.addStudent(student);
      } else {
        // Updating an existing student
        await studentProvider.updateStudent(student);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.student == null ? 'Student added' : 'Student updated')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.student == null ? 'Add Student' : 'Edit Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter last name' : null,
              ),
              TextFormField(
                controller: domainController,
                decoration: const InputDecoration(labelText: 'Domain'),
                validator: (value) => value == null || value.isEmpty ? 'Enter domain' : null,
              ),
              TextFormField(
                controller: hubController,
                decoration: const InputDecoration(labelText: 'Hub'),
                validator: (value) => value == null || value.isEmpty ? 'Enter hub' : null,
              ),
              TextFormField(
                controller: batchController,
                decoration: const InputDecoration(labelText: 'Batch'),
                validator: (value) => value == null || value.isEmpty ? 'Enter batch' : null,
              ),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date of Birth (DD)'),
                validator: (value) => value == null || value.isEmpty ? 'Enter date' : null,
              ),
              TextFormField(
                controller: monthController,
                decoration: const InputDecoration(labelText: 'Month of Birth'),
                validator: (value) => value == null || value.isEmpty ? 'Enter month' : null,
              ),
              TextFormField(
                controller: genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
                validator: (value) => value == null || value.isEmpty ? 'Enter gender' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStudent,
                child: Text(widget.student == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
