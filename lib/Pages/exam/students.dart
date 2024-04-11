class Student {
  String id;
  String name;
  String address;
  DateTime birthDate;
  String gender;
  String gmail;
  double score;


  Student({required this.id,required this.name, required this.address, required this.birthDate,required this.gender,
    required this.gmail,required this.score});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      birthDate: DateTime.parse(map['birthDate']),
      gender: map['gender'],
      gmail: map['gmail'],
      score: map['score'],
    );
  }
}