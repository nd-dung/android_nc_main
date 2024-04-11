import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title: Text('Students Screen')
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child:Column(
            children:[
              Text('Students Information',style: GoogleFonts.roboto(fontSize: 17,fontWeight: FontWeight.bold),),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Student ID',
                  labelText: 'Student Name',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 10,),
              const TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Student Name',
                    labelText: 'Student Name',
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 10,),
              const TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Student Date of Birth',
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 10,),
              const TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Student Gender',
                    labelText: 'Gender',
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 10,),
              const TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Student Gmail',
                    labelText: 'Gmail',
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 10,),
              const TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Student AVG Score',
                    labelText: 'AVG Score',
                    border: OutlineInputBorder()
                ),
              ),
            ]

          )
        ),
      )
    );
  }
}

