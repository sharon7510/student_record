import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/student.dart';
import '../state/student_provider.dart';
import 'StudentDetailScreen.dart';
import 'StudentFormScreen.dart';

class StudentListScreen extends StatefulWidget {
  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final hi = MediaQuery.of(context).size.height;
    final wi = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      appBar: AppBar(
        title: const Text("Student List"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  _searchQuery = query.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Search students...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<Student>>(
        stream: studentProvider.studentsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No students available"));
          }
          // Filter the students based on the search query
          final students = snapshot.data!.where((student) {
            final nameMatch = student.name.toLowerCase().contains(_searchQuery);
            final lastNameMatch = student.lastName.toLowerCase().contains(_searchQuery);
            final domainMatch = student.domain.toLowerCase().contains(_searchQuery);
            return nameMatch || lastNameMatch || domainMatch;
          }).toList();
          if (students.isEmpty) {
            return const Center(child: Text("No students found"));
          }
          return GridView.builder(
            shrinkWrap: true,
            itemCount: students.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
            itemBuilder: (BuildContext context, int index) {
              final student = students[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentDetailScreen(student: student),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: hi / 13,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: hi / 30),
                                  Text(
                                    student.date,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: hi / 38,
                                    ),
                                  ),
                                  Text(
                                    student.month,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: hi / 45,
                                    ),
                                  ),
                                  SizedBox(height: hi / 25),
                                  Text(
                                    student.name,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: hi / 45,
                                    ),
                                  ),
                                  Text(
                                    student.lastName,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: hi / 45,
                                    ),
                                  ),
                                  Text(
                                    student.domain.toUpperCase(),
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: hi / 4,
                            width: hi / 4 - 10,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: student.gender == "Male"
                                    ? const AssetImage("assets/3d-render-little-boy-with-eyeglasses-blue-shirt.png")
                                    : const AssetImage("assets/3d-illustration-cute-little-girl-with-green-jacket.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: hi / 17,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            student.gender == "Male" ? Colors.pink.shade100 : Colors.red.shade100,
                            Colors.white,
                          ]),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(student.hub),
                                  Text(student.batch),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => StudentFormScreen(student: student),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await studentProvider.deleteStudent(student.id);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Student deleted")),
                                      );
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
