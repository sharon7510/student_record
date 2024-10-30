class Student {
  final String name;
  final String lastName;
  final String domain;
  final String hub;
  final String bach;
  final String date;
  final String month;
  final String gender;

  Student({
    required this.name,
    required this.lastName,
    required this.domain,
    required this.hub,
    required this.bach,
    required this.date,
    required this.month,
    required this.gender,
  });

  // Factory method to create a Student from Firestore data
  factory Student.fromFirestore(Map<String, dynamic> data) {
    return Student(
      name: data['name'] ?? '',
      lastName: data['last_name'] ?? '',
      domain: data['domain'] ?? '',
      hub: data['hub'] ?? '',
      bach: data['bach'] ?? '',
      date: data['date'] ?? '',
      month: data['month'] ?? '',
      gender: data['gender'] ?? '',
    );
  }
}
