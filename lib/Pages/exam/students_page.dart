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
              TextField(
                  onChanged: (_){

                  },
                  autocorrect: false,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Student id",
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue)),
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue)),
                    hintStyle: const TextStyle(
                      color: Colors.lightBlue,
                    ),
                  ),
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color:Colors.black
                  )
              ),

            ]

          )
        ),
      )
    );
  }
}

