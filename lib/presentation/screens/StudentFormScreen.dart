import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/student.dart';
import '../state/student_provider.dart';

const List<DropdownMenuItem<String>> domains = [
  DropdownMenuItem(value: 'Web Development', child: Text('Web Development')),
  DropdownMenuItem(value: 'Mobile App Development', child: Text('Mobile App Development')),
  DropdownMenuItem(value: 'Cyber Security', child: Text('Cyber Security')),
  DropdownMenuItem(value: 'Artificial Intelligence / Machine Learning', child: Text('Artificial Intelligence / Machine Learning')),
  DropdownMenuItem(value: 'Game Development', child: Text('Game Development')),
  DropdownMenuItem(value: 'Data Science', child: Text('Data Science')),
  DropdownMenuItem(value: 'BlockChain', child: Text('BlockChain')),
  DropdownMenuItem(value: 'Augmented Reality / Virtual Reality', child: Text('Augmented Reality / Virtual Reality')),
  DropdownMenuItem(value: 'Software Testing', child: Text('Software Testing')),
  DropdownMenuItem(value: 'DevOps', child: Text('DevOps')),
];

const List<DropdownMenuItem<String>> hubs = [
  DropdownMenuItem(value: 'Bengaluru', child: Text('Bengaluru')),
  DropdownMenuItem(value: 'Calicut', child: Text('Calicut')),
  DropdownMenuItem(value: 'Thrivandrum', child: Text('Thrivandrum')),
  DropdownMenuItem(value: 'Kochi', child: Text('Kochi')),
  DropdownMenuItem(value: 'Coimbatore', child: Text('Coimbatore')),
  DropdownMenuItem(value: 'Chennai', child: Text('Chennai')),
];

const List<DropdownMenuItem<String>> months = [
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
];



class StudentFormScreen extends StatefulWidget {
  final Student? student;

  const StudentFormScreen({Key? key, this.student}) : super(key: key);

  @override
  _StudentFormScreenState createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController batchController = TextEditingController();

  String? selectedDay;
  String? selectedMonth;
  String? selectedGender;
  String? selectedDomain;
  String? selectedHub;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      nameController.text = widget.student!.name;
      lastNameController.text = widget.student!.lastName;
      batchController.text = widget.student!.batch;
      selectedDay = widget.student!.date;
      selectedMonth = widget.student!.month;
      selectedGender = widget.student!.gender;
      selectedDomain = widget.student!.domain;  // Set domain
      selectedHub = widget.student!.hub;        // Set hub
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    batchController.dispose();
    super.dispose();
  }

  Future<void> _saveStudent() async {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        id: widget.student?.id ?? '',
        name: nameController.text,
        lastName: lastNameController.text,
        domain: selectedDomain ?? '',
        hub: selectedHub ?? '',
        batch: batchController.text,
        date: selectedDay ?? '',
        month: selectedMonth ?? '',
        gender: selectedGender ?? '',
      );

      final studentProvider = Provider.of<StudentProvider>(context, listen: false);
      if (widget.student == null) {
        await studentProvider.addStudent(student);
      } else {
        await studentProvider.updateStudent(student);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.student == null ? 'Student added' : 'Student updated')),
      );
      Navigator.pop(context);
    }
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String validationMessage,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) => value == null || value.isEmpty ? validationMessage : null,
    );
  }

  Widget _buildDropdownFormField({
    required String label,
    required List<DropdownMenuItem<String>> items,
    required String? selectedValue,
    required Function(String?) onChanged,
    required String validationMessage,
  }) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(labelText: label),
      items: items,
      onChanged: onChanged,
      validator: (value) => value == null || value.isEmpty ? validationMessage : null,
    );
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
                    child: SizedBox(
                      width: wi / 4,
                      child: ListView(
                        children: [
                          _buildTextFormField(
                            controller: nameController,
                            label: 'Name',
                            validationMessage: 'Enter name',
                          ),
                          _buildTextFormField(
                            controller: lastNameController,
                            label: 'Last Name',
                            validationMessage: 'Enter last name',
                          ),
                          _buildTextFormField(
                            controller: batchController,
                            label: 'Batch',
                            validationMessage: 'Enter batch',
                          ),
                          _buildDropdownFormField(
                            label: 'Domain',
                            items: domains,
                            selectedValue: selectedDomain,
                            onChanged: (value) => setState(() => selectedDomain = value),
                            validationMessage: 'Select Domain',
                          ),
                          _buildDropdownFormField(
                            label: 'Hub',
                            items: hubs,
                            selectedValue: selectedHub,
                            onChanged: (value) => setState(() => selectedHub = value),
                            validationMessage: 'Select Hub',
                          ),
                          _buildDropdownFormField(
                            label: 'Date of Birth (Day)',
                            items: List.generate(31, (index) {
                              final day = (index + 1).toString().padLeft(2, '0');
                              return DropdownMenuItem(value: day, child: Text(day));
                            }),
                            selectedValue: selectedDay,
                            onChanged: (value) => setState(() => selectedDay = value),
                            validationMessage: 'Select day',
                          ),
                          _buildDropdownFormField(
                            label: 'Month of Birth',
                            items: months,
                            selectedValue: selectedMonth,
                            onChanged: (value) => setState(() => selectedMonth = value),
                            validationMessage: 'Select month',
                          ),
                          _buildDropdownFormField(
                            label: 'Gender',
                            items: [
                              const DropdownMenuItem(value: 'Male', child: Text('Male')),
                              const DropdownMenuItem(value: 'Female', child: Text('Female')),
                            ],
                            selectedValue: selectedGender,
                            onChanged: (value) => setState(() => selectedGender = value),
                            validationMessage: 'Select gender',
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(
                            height: hi / 20,
                            color: Colors.deepPurple,
                            onPressed: _saveStudent,
                            child: Text(
                              widget.student == null ? 'Add Student' : 'Update',
                              style: const TextStyle(color: Colors.white),
                            ),
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

