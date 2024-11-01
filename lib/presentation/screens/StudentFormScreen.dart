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

  // Text controllers for other fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController domainController = TextEditingController();
  final TextEditingController hubController = TextEditingController();
  final TextEditingController batchController = TextEditingController();

  String? selectedDay;
  String? selectedMonth;
  String? selectedGender;

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
      selectedDay = widget.student!.date;
      selectedMonth = widget.student!.month;
      selectedGender = widget.student!.gender;
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
        date: selectedDay ?? '',
        month: selectedMonth ?? '',
        gender: selectedGender ?? '',
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
    final hi = MediaQuery.of(context).size.height;
    final wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(title: Text(widget.student == null ? 'Add Student' : 'Edit Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: hi / 2,
            width: wi / 2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: double.infinity,
                  width: wi / 5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/bg removed.png"),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: wi / 4,
                      child: ListView(
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(labelText: 'Name'),
                            validator: (value) =>
                            value == null || value.isEmpty ? 'Enter name' : null,
                          ),
                          TextFormField(
                            controller: lastNameController,
                            decoration: const InputDecoration(labelText: 'Last Name'),
                            validator: (value) =>
                            value == null || value.isEmpty ? 'Enter last name' : null,
                          ),
                          TextFormField(
                            controller: domainController,
                            decoration: const InputDecoration(labelText: 'Domain'),
                            validator: (value) =>
                            value == null || value.isEmpty ? 'Enter domain' : null,
                          ),
                          TextFormField(
                            controller: hubController,
                            decoration: const InputDecoration(labelText: 'Hub'),
                            validator: (value) =>
                            value == null || value.isEmpty ? 'Enter hub' : null,
                          ),
                          TextFormField(
                            controller: batchController,
                            decoration: const InputDecoration(labelText: 'Batch'),
                            validator: (value) =>
                            value == null || value.isEmpty ? 'Enter batch' : null,
                          ),
                          DropdownButtonFormField<String>(
                            value: selectedDay,
                            decoration: const InputDecoration(
                              labelText: 'Date of Birth (Day)',
                            ),
                            items: List.generate(31, (index) {
                              final day = (index + 1).toString().padLeft(2, '0');
                              return DropdownMenuItem(
                                value: day,
                                child: Text(day),
                              );
                            }),
                            onChanged: (value) {
                              setState(() {
                                selectedDay = value;
                              });
                            },
                            validator: (value) =>
                            value == null || value.isEmpty ? 'Select day' : null,
                          ),
                          DropdownButtonFormField<String>(
                            value: selectedMonth,
                            decoration: const InputDecoration(
                              labelText: 'Month of Birth',
                            ),
                            items: const [
                              DropdownMenuItem(value: 'January', child: Text('January')),
                              DropdownMenuItem(value: 'February', child: Text('February')),
                              DropdownMenuItem(value: 'March', child: Text('March')),
                              DropdownMenuItem(value: 'April', child: Text('April')),
                              DropdownMenuItem(value: 'May', child: Text('May')),
                              DropdownMenuItem(value: 'June', child: Text('June')),
                              DropdownMenuItem(value: 'July', child: Text('July')),
                              DropdownMenuItem(value: 'August', child: Text('August')),
                              DropdownMenuItem(value: 'September', child: Text('September')),
                              DropdownMenuItem(value: 'October', child: Text('October')),
                              DropdownMenuItem(value: 'November', child: Text('November')),
                              DropdownMenuItem(value: 'December', child: Text('December')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedMonth = value;
                              });
                            },
                            validator: (value) =>
                            value == null || value.isEmpty ? 'Select month' : null,
                          ),
                          DropdownButtonFormField<String>(
                            value: selectedGender,
                            decoration: const InputDecoration(
                              labelText: 'Gender',
                            ),
                            items: const [
                              DropdownMenuItem(value: 'Male', child: Text('Male')),
                              DropdownMenuItem(value: 'Female', child: Text('Female')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                            validator: (value) =>
                            value == null || value.isEmpty ? 'Select gender' : null,
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(
                            height: hi/20,
                            color: Colors.deepPurple,
                            onPressed: _saveStudent,
                            child: Text(widget.student == null ? 'Add Student' : 'Update',style: TextStyle(color: Colors.white)
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
