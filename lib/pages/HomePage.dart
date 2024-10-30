import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model class/StudentModelClass.dart';

TextStyle style({double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? Colors.white,
      fontSize: fontSize! / 38);
}

TextEditingController controllerName = TextEditingController();
TextEditingController controllerLastName = TextEditingController();
TextEditingController controllerDomain = TextEditingController();
TextEditingController controllerHub = TextEditingController();
TextEditingController controllerBach = TextEditingController();
TextEditingController controllerDate = TextEditingController();

Future<void> _saveStudentData(BuildContext context) async {
  if (formKey.currentState!.validate()) {
    try {
      // Attempt to add student data to Firestore
      await FirebaseFirestore.instance.collection('students').add({
        'name': controllerName.text,
        'last_name': controllerLastName.text,
        'domain': controllerDomain.text,
        'hub': controllerHub.text,
        'bach': controllerBach.text,
        'date': controllerDate.text,
        'month': selectedMonth,
        'gender': selectedGender,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student data added successfully')),
      );

      // Clear fields after submission
      controllerName.clear();
      controllerLastName.clear();
      controllerDomain.clear();
      controllerHub.clear();
      controllerBach.clear();
    } catch (e) {
      // Show error message on failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add data: $e')),
      );
    }
  }
}

TextStyle styleBold =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
TextStyle styleSmall =
    const TextStyle(fontWeight: FontWeight.normal, fontSize: 12);
TextStyle styleName =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25,overflow: TextOverflow.ellipsis);
TextStyle styleVerySmall =
    const TextStyle(fontWeight: FontWeight.normal, fontSize: 10);

bool animatedContainer = true;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final hi = MediaQuery.of(context).size.height;
    final wi = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: !animatedContainer
          ? FloatingActionButton.extended(
              backgroundColor: Colors.black,
              onPressed: () {
                setState(() {
                  animatedContainer = !animatedContainer!;
                });
              },
              label: Text(
                "Add Student",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
          : FloatingActionButton.extended(
              backgroundColor: Colors.black,
              onPressed: () {
                _saveStudentData(context);
                setState(() {
                  animatedContainer = !animatedContainer!;
                });
              },
              label: Text(
                "save",
                style: TextStyle(color: Colors.white),
              ),
            ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 1000) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading(height: hi),
                  Row(
                    children: [
                      Expanded(child: body(width: wi - 400, height: hi)),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        width: animatedContainer ? 390 : 0,
                        height: hi,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: !animatedContainer? Container() :  AddStudent(),
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

final List<String> months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];
final List<String> genders = ["Male", "Female"];

String? selectedMonth;
String? selectedGender;

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

final formKey = GlobalKey<FormState>();

bool still = formKey.currentState!.validate();

class _AddStudentState extends State<AddStudent> {
  @override
  Widget build(BuildContext context) {
    final hi = MediaQuery.of(context).size.height;
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: controllerName,
                decoration: InputDecoration(label: Text("Name")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controllerLastName,
                decoration: InputDecoration(label: Text("Last Name")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controllerDomain,
                decoration: InputDecoration(label: Text("Domain")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a domain';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controllerHub,
                decoration: InputDecoration(label: Text("Hub")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a hub';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controllerBach,
                decoration: InputDecoration(label: Text("Bach")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a bach';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controllerDate,
                decoration: InputDecoration(label: Text("Date of birth")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a bach';
                  }
                  final date = int.tryParse(value);
                  if (date == null || date < 1 || date > 31) {
                    return 'Enter a valid date (1-31)';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedMonth,
                decoration: InputDecoration(labelText: 'Month'),
                items: months.map((month) {
                  return DropdownMenuItem(
                    value: month,
                    child: Text(month),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMonth = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a month';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(labelText: 'Gender'),
                items: genders.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a gender';
                  }
                  return null;
                },
              ),
            ],
          ),
        ));
  }
}

Widget heading({required double? height}) {
  return Container(
    margin: EdgeInsets.all(10),
    height: height! / 15,
    child: Center(
      child: Row(
        children: [
          Text("Heloo Sam . . .", style: style(fontSize: height)),
        ],
      ),
    ),
  );
}

Widget body({required double? height, required double? width}) {
  double hi = 70;
  double padding = 20;
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: Colors.grey.shade50,
        // borderRadius: BorderRadius.all(Radius.circular(10))
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
    child: Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SizedBox(height: height! / hi,),
          Padding(
            padding: EdgeInsets.only(top: padding, bottom: padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Students",
                  style: style(
                      fontSize: height,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                search(width: width),
              ],
            ),
          ),
          gridView(height: hi, width: width),
        ],
      ),
    ),
  );
}

Widget search({double? width}) {
  return SizedBox(
      width: width! / 5,
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                size: width! / 70,
              ),
            ),
            label: Text(
              "Search",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey.shade400),
            )),
      ));
}

Stream<List<Student>> fetchStudents() {
  return FirebaseFirestore.instance.collection('students').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Student.fromFirestore(doc.data()))
          .toList());
}

Widget gridView({required double? height, required double? width}) {
  double spacing = 10;
  return StreamBuilder<List<Student>>(
    stream: fetchStudents(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No students found'));
      }
      final students = snapshot.data!;
      return GridView.builder(
        shrinkWrap: true,
        itemCount: students.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing),
        itemBuilder: (BuildContext context, int index) {
          // if(student.gender=="male"){}else{}
          final student = students[index];
          return studentsProfile(
              height: height,
              width: width,
              name: student.name,
              bach: student.bach,
              dateOfBirth: student.date,
              domain: student.domain,
              gender: student.gender != "Male",
              hub: student.hub,
              lastname: student.lastName,
              monthOfBirth: student.month);
        },
      );
    },
  );
}

Widget studentsProfile({
  required double? height,
  required double? width,
  String? hub,
  String? bach,
  String? dateOfBirth,
  String? monthOfBirth,
  String? name,
  String? lastname,
  String? domain,
  bool? gender,
}) {
  double radius = 30;
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(radius))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius)),
            // color: Colors.deepPurpleAccent
          ),
          child: Row(
            children: [
              details(
                height: height,
                width: width,
                dateOfBirth: dateOfBirth,
                monthOfBirth: monthOfBirth,
                name: name,
                lastname: lastname,
                domain: domain,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.bottomCenter,
                          image: gender ?? false
                              ? const AssetImage(
                                  "assets/3d-illustration-cute-little-girl-with-green-jacket.png")
                              : const AssetImage(
                                  "assets/3d-render-little-boy-with-eyeglasses-blue-shirt.png"))),
                ),
              )
            ],
          ),
        )),
        Container(
          height: height! / 1.3,
          decoration: BoxDecoration(
              // color: Colors.deepPurple.shade100,
              gradient: LinearGradient(colors: [
                !gender!? Colors.blue.shade100 : Colors.pink.shade100,
                Colors.white]),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(radius),
                  bottomLeft: Radius.circular(radius))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(hub ?? "Bengaluru",
                        style: TextStyle(
                            fontSize: height! / 4,
                            fontWeight: FontWeight.bold)),
                    Text(bach ?? "BCB201", style: styleSmall),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget details({
  String? dateOfBirth,
  String? monthOfBirth,
  String? name,
  String? lastname,
  String? domain,
  required double? width,
  required double? height,
}) {
  return Container(
    // color: Colors.redAccent,
    width: 100,
    height: double.infinity,
    child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dateOfBirth ?? "19", style: styleBold),
          Text(monthOfBirth ?? "Mar", style: styleSmall),
          SizedBox(
            height: 50,
          ),
          Text(name ?? "Sharon", style: styleName),
          Text(lastname ?? "Antony", style: styleName),
          SizedBox(
            height: 5,
          ),
          Text(domain ?? "Flutter Developer", style: styleVerySmall)
        ],
      ),
    ),
  );
}
