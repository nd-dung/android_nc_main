import 'package:english_learning/Pages/exam/students.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController gmailController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Students Information',
                style: GoogleFonts.roboto(
                    fontSize: 17, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  hintText: 'Enter Student ID',
                  labelText: 'Student ID',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter Student Name',
                  labelText: 'Student Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: dobController,
                decoration: InputDecoration(
                  hintText: 'Enter Student Date of Birth',
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: genderController,
                decoration: InputDecoration(
                  hintText: 'Enter Student Gender',
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: gmailController,
                decoration: InputDecoration(
                  hintText: 'Enter Student Gmail',
                  labelText: 'Gmail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: scoreController,
                decoration: InputDecoration(
                  hintText: 'Enter Student AVG Score',
                  labelText: 'AVG Score',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: 'Enter Student Address',
                  labelText: 'Student Address',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  addStudentToFirebase();
                },
                child: Text('Submit'),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('students')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  return SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot student = snapshot.data!.docs[index];
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person, size: 50),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(student['name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Text('ID: ${student['id']}',
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('Score: ${student['score']}',
                                            style: TextStyle(fontSize: 16)),
                                        Text('DOB: ${student['birthDate']}',
                                            style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Gmail: ${student['gmail']}',
                                        style: TextStyle(fontSize: 16)),
                                    Text('Gender: ${student['gender']}',
                                        style: TextStyle(fontSize: 16)),
                                    Text('Address: ${student['address']}',
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addStudentToFirebase() async {
    String id = idController.text;
    String name = nameController.text;
    String address = addressController.text;
    String birthDate = dobController.text;
    String gender = genderController.text;
    String gmail = gmailController.text;
    double score = double.parse(scoreController.text);

    Student student = Student(
      id: id,
      name: name,
      address: address,
      birthDate: birthDate,
      gender: gender,
      gmail: gmail,
      score: score,
    );

    CollectionReference students =
        FirebaseFirestore.instance.collection('students');
    return students
        .doc(student.id)
        .set(student.toMap())
        .then((value) => print("Student Added"))
        .catchError((error) => print("Failed to add student: $error"));
  }
}
