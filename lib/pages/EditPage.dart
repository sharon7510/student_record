// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../model class/StudentModelClass.dart';
//
// class EditStudent extends StatefulWidget {
//   final Student student;
//
//   EditStudent({required this.student});
//
//   @override
//   _EditStudentState createState() => _EditStudentState();
// }
//
// class _EditStudentState extends State<EditStudent> {
//   final _formKey = GlobalKey<FormState>();
//
//   late TextEditingController _nameController;
//   late TextEditingController _lastNameController;
//   late TextEditingController _domainController;
//   late TextEditingController _hubController;
//   late TextEditingController _bachController;
//   late TextEditingController _dateController;
//   String? _selectedMonth;
//   String? _selectedGender;
//
//   final List<String> months = [
//     "January", "February", "March", "April", "May", "June",
//     "July", "August", "September", "October", "November", "December",
//   ];
//
//   final List<String> genders = ["Male", "Female", "Other"];
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.student.name);
//     _lastNameController = TextEditingController(text: widget.student.lastName);
//     _domainController = TextEditingController(text: widget.student.domain);
//     _hubController = TextEditingController(text: widget.student.hub);
//     _bachController = TextEditingController(text: widget.student.bach);
//     _dateController = TextEditingController(text: widget.student.date);
//     _selectedMonth = widget.student.month;
//     _selectedGender = widget.student.gender;
//   }
//
//   Future<void> _updateStudent() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await FirebaseFirestore.instance
//             .collection('students')
//             .doc(widget.student.id)
//             .update({
//           'name': _nameController.text,
//           'last_name': _lastNameController.text,
//           'domain': _domainController.text,
//           'hub': _hubController.text,
//           'bach': _bachController.text,
//           'date': _dateController.text,
//           'month': _selectedMonth,
//           'gender': _selectedGender,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Student data updated successfully')),
//         );
//
//         Navigator.pop(context);
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to update data: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Edit Student')),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//                 validator: (value) => value!.isEmpty ? 'Enter name' : null,
//               ),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(labelText: 'Last Name'),
//                 validator: (value) => value!.isEmpty ? 'Enter last name' : null,
//               ),
//               TextFormField(
//                 controller: _domainController,
//                 decoration: InputDecoration(labelText: 'Domain'),
//                 validator: (value) => value!.isEmpty ? 'Enter domain' : null,
//               ),
//               TextFormField(
//                 controller: _hubController,
//                 decoration: InputDecoration(labelText: 'Hub'),
//                 validator: (value) => value!.isEmpty ? 'Enter hub' : null,
//               ),
//               TextFormField(
//                 controller: _bachController,
//                 decoration: InputDecoration(labelText: 'Bach'),
//                 validator: (value) => value!.isEmpty ? 'Enter bach' : null,
//               ),
//               TextFormField(
//                 controller: _dateController,
//                 decoration: InputDecoration(labelText: 'Date'),
//                 validator: (value) {
//                   final date = int.tryParse(value!);
//                   if (date == null || date < 1 || date > 31) {
//                     return 'Enter a valid date (1-31)';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.number,
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedMonth,
//                 decoration: InputDecoration(labelText: 'Month'),
//                 items: months.map((month) {
//                   return DropdownMenuItem(
//                     value: month,
//                     child: Text(month),
//                   );
//                 }).toList(),
//                 onChanged: (value) => setState(() => _selectedMonth = value),
//                 validator: (value) => value == null ? 'Select month' : null,
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 decoration: InputDecoration(labelText: 'Gender'),
//                 items: genders.map((gender) {
//                   return DropdownMenuItem(
//                     value: gender,
//                     child: Text(gender),
//                   );
//                 }).toList(),
//                 onChanged: (value) => setState(() => _selectedGender = value),
//                 validator: (value) => value == null ? 'Select gender' : null,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _updateStudent,
//                 child: Text('Save Changes'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
