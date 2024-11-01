import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_record/presentation/screens/StudentDetailScreen.dart';
import 'package:student_record/presentation/screens/StudentFormScreen.dart';
import 'package:student_record/presentation/state/student_provider.dart';
import '../../domain/entities/student.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = (screenWidth / 200).floor();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
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

          // Filter students based on search query
          final students = snapshot.data!
              .where((student) => student.name.toLowerCase().contains(_searchQuery) ||
              student.lastName.toLowerCase().contains(_searchQuery) ||
              student.domain.toLowerCase().contains(_searchQuery))
              .toList();

          if (students.isEmpty) {
            return const Center(child: Text("No students found"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: students.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              final student = students[index];
              return StudentItem(student: student);
            },
          );
        },
      ),
    );
  }
}

class StudentItem extends StatelessWidget {
  final Student student;

  const StudentItem({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentDetailScreen(student: student),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight / 30),
                      Text(
                        student.date,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight / 38,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        student.month,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight / 45,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: screenHeight / 25),
                      Text(
                        student.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight / 38,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        student.lastName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight / 38,
                          overflow: TextOverflow.ellipsis,
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
                Container(
                  height: screenHeight / 4,
                  width: screenHeight / 4 - 10,
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
              height: screenHeight / 17,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    student.gender == "Male" ? Colors.pink.shade100 : Colors.red.shade100,
                    Colors.white,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(student.hub),
                        Text(student.batch),
                      ],
                    ),
                    Row(
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
  }
}
