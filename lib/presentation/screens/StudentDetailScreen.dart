import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/student.dart';
import '../state/student_provider.dart';
import 'StudentFormScreen.dart';

List<String>imagesBoys=[
  "assets/images/boys.png",
  "assets/images/boys2.png",
];

List<String>imagesGirls=[
  "assets/images/Untitled (1).png",
  "assets/images/Untitled.png"
];



class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({Key? key, required this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    final hi = MediaQuery.of(context).size.height;
    final wi = MediaQuery.of(context).size.height;

    return Scaffold(
      // floatingActionButton: Transform.translate(
      //     offset: Offset(-hi/2.5, -hi/6.7),
      //   child: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       FloatingActionButton(
      //         backgroundColor: Colors.deepPurpleAccent,
      //         heroTag: 1,
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => StudentFormScreen(student: student),
      //           ),
      //         );
      //       },child: Icon(Icons.edit,color: Colors.white),),
      //       const SizedBox(width: 10,),
      //       FloatingActionButton(
      //         backgroundColor: Colors.deepPurpleAccent,
      //         heroTag: 2,
      //         onPressed: () async {
      //           await studentProvider.deleteStudent(student.id);
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(content: Text("Student deleted")),
      //           );
      //           Navigator.pop(context); // Go back to the list screen
      //         },child: Icon(Icons.delete,color: Colors.white,),),
      //     ],
      //   ),
      // ),
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('${student.name.toUpperCase()} ${student.lastName.toUpperCase()}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: hi/1.5,
            width: wi/0.8,
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)
                    ),
                    // color: Colors.purpleAccent,
                  ),
                  height: double.infinity,
                  width: wi/2,
                  child: CarouselSlider.builder(
                      itemCount: imagesBoys.length,
                      options: CarouselOptions(
                        autoPlay: true,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Image(
                          fit: BoxFit.cover,
                            image: AssetImage(student.gender=="Male"? imagesBoys[index] : imagesGirls[index])
                        );
                      }
                      ),
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FloatingActionButton(
                            backgroundColor: Colors.deepPurpleAccent,
                            heroTag: 1,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentFormScreen(student: student),
                                ),
                              );
                            },child: Icon(Icons.edit,color: Colors.white),),
                          const SizedBox(width: 10,),
                          FloatingActionButton(
                            backgroundColor: Colors.deepPurpleAccent,
                            heroTag: 2,
                            onPressed: () async {
                              await studentProvider.deleteStudent(student.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Student deleted")),
                              );
                              Navigator.pop(context); // Go back to the list screen
                            },child: Icon(Icons.delete,color: Colors.white,),),
                        ],
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: wi/1.3-20,
                      child: Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${student.name.toUpperCase()} ${student.lastName.toUpperCase()}",
                                  // style: Theme.of(context).textTheme.titleLarge
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple
                                ),
                              ),
                              Text(student.domain.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20
                                  )),
                              SizedBox(
                                height: hi/10,
                              ),
                              Text(student.date,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                                ),
                              ),
                              Text(student.month,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30
                                ),
                              ),
                              SizedBox(
                                height: hi/10,
                              ),
                              Text(student.hub.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                  )),
                              const SizedBox(height: 8),
                              Text(student.batch,
                                  style: const TextStyle(
                                    fontSize: 20
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


