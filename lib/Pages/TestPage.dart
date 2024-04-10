import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Testing'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(15.0),
                    height: 100.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      children: [
                        Image(image: AssetImage('assets/images/testing.png')),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "TEST 1",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "Bắt đầu thi thử",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '120 câu',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '60 phút',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}















// import 'dart:core';
//
// import 'package:audioplayers/audioplayers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:english_learning/Models/ReadingModels.dart';
// import 'package:english_learning/global/common/toast.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Models/Examination.dart';
// import '../Models/TestFormModels.dart';
//
// class TestPage extends StatefulWidget {
//   @override
//   State<TestPage> createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//   List<int> userReadingAnswers = [];
//   List<int> userListeningAnswers = [];
//   List<TestFormModels> readingQuestions =[];
//   List<TestFormModels> listeningQuestions=[];
//   int readingScore = 0;
//   int listeningScore = 0;
//   late Future<List<TestFormModels>> _loadingReadingData;
//   late Future<List<TestFormModels>> _loadingListeningData;
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   late String? user = '';
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     loadUser();
//     _loadingReadingData = _loadReadingData();
//     _loadingListeningData = _loadListeningData();
//     audioPlayer.onPlayerStateChanged.listen((state) {
//       setState(() {
//         isPlaying = state == PlayerState.playing;
//       });
//     });
//     audioPlayer.onDurationChanged.listen((newDuration) {
//       setState(() {
//         duration = newDuration;
//       });
//     });
//     audioPlayer.onPositionChanged.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     audioPlayer.stop();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Examination'),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//         ),
//         body: ListView(
//           children: [
//             //Reading part
//             FutureBuilder<List<TestFormModels>>(
//               future: _loadingReadingData,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }else{
//                   readingQuestions = snapshot.data!;
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Row(
//                         children: [
//                           Text('PART 1: READING', style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),),
//
//                         ],
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: readingQuestions.isEmpty ? const [Text('Something went wrong')] : List.generate(10, (index) {
//                           return ReadingQuestionForm(
//                             question: '${index+1}. ${readingQuestions[index].question}',
//                             answerList: [
//                               readingQuestions[index].A,
//                               readingQuestions[index].B,
//                               readingQuestions[index].C,
//                               readingQuestions[index].D
//                             ],
//                             onAnswered: (answer) {
//                               setState(() {
//                                 userReadingAnswers[index] = answer;
//                                 print(answer);
//                               });
//                             },
//                             groupValue: userReadingAnswers[index],
//                           );
//                         }),
//                       )
//                     ],
//                   );
//                 }
//               }
//             ),
//             //Listening part
//             const Text('PART 2: LISTENING', style: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),),
//             Slider(
//                 min: 0,
//                 max: duration.inSeconds.toDouble(),
//                 value: position.inSeconds.toDouble(),
//                 onChanged: (value) async {}),
//             Padding(
//               padding: EdgeInsets.all(8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(formatTime(position)),
//                   Text(formatTime(duration - position)),
//                 ],
//               ),
//             ),
//             IconButton(
//               iconSize: 30,
//               onPressed: () async {
//                 if (isPlaying) {
//                   await audioPlayer.pause();
//                 } else {
//                   await audioPlayer
//                       .play(UrlSource('https://firebasestorage.googleapis.com/v0/b/fir-testing-c1173.appspot.com/o/audio%2FJIM_s%20TOEIC%20LC%20TEST%2001-%20Part%204.mp3?alt=media&token= 37e510aa-79bb-487a-9c85-7dfdd5366e0b'));
//                 }
//               },
//               icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
//
//             ),
//             FutureBuilder<List<TestFormModels>>(
//                 future: _loadingListeningData,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   }else{
//                       listeningQuestions= snapshot.data!;
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: listeningQuestions.isEmpty ? const [Text('Something went wrong')] :List.generate(10, (index) {
//                             return ReadingQuestionForm(
//                               question: '${index+1}. ${listeningQuestions[index].question}',
//                               answerList: [
//                                 listeningQuestions[index].A,
//                                 listeningQuestions[index].B,
//                                 listeningQuestions[index].C,
//                                 listeningQuestions[index].D
//                               ],
//                               onAnswered: (answer) {
//                                 setState(() {
//                                   userListeningAnswers[index] = answer;
//                                   print(answer);
//                                 });
//                               },
//                               groupValue: userListeningAnswers[index],
//                             );
//                           }),
//                         )
//                       ],
//                     );
//                   }
//                 }
//             ),
//             ElevatedButton(onPressed: ()=>totalScore(), child:const  Text('Submit'),),
//           ],
//         ));
//   }
//
//   Future<List<TestFormModels>> _loadReadingData() async {
//     List<TestFormModels> readingQuestions = [];
//     final cauTheoMaDe = await FirebaseFirestore.instance
//         .collection('CT_ThiDoc')
//         .get();
//     if (cauTheoMaDe.docs.isNotEmpty) {
//       for (var element in cauTheoMaDe.docs) {
//         readingQuestions.add(TestFormModels(
//             made: element['made'],
//             question: element['question'],
//             A: element['A'],
//             B: element['B'],
//             C: element['C'],
//             D: element['D'],
//             awnser: element['awnser']));
//       }
//       userReadingAnswers = List.filled(readingQuestions.length, -1);
//       readingQuestions.shuffle();
//     }
//     return readingQuestions;
//   }
//
//   Future<List<TestFormModels>> _loadListeningData() async {
//     List<TestFormModels> listeningQuestions = [];
//     final cauTheoMaDe = await FirebaseFirestore.instance
//         .collection('CT_ThiNghe')
//         .get();
//     if (cauTheoMaDe.docs.isNotEmpty) {
//       for (var element in cauTheoMaDe.docs) {
//         listeningQuestions.add( TestFormModels(
//             made: element['made'],
//             question: element['question'],
//             A: element['A'],
//             B: element['B'],
//             C: element['C'],
//             D: element['D'],
//             awnser: element['awnser']));
//       }
//     }
//     userListeningAnswers =List.filled(listeningQuestions.length, -1);
//     listeningQuestions.shuffle();
//     return listeningQuestions;
//   }
//
//   void calculateReadingScore(List<TestFormModels> questions) {
//     for (int i = 0; i < questions.length; i++) {
//       if (userReadingAnswers[i] == int.parse(questions[i].awnser)) {
//         readingScore++;
//       }
//     }
//   }
//
//   void calculateListeningScore(List<TestFormModels> questions) {
//     for (int i = 0; i < questions.length; i++) {
//       if (userListeningAnswers[i] == int.parse(questions[i].awnser)) {
//         listeningScore++;
//       }
//     }
//   }
//
//   void totalScore(){
//     calculateListeningScore(listeningQuestions);
//     calculateReadingScore(readingQuestions);
//     print('reading${readingQuestions.length}');
//     int totalScore = readingScore + listeningScore;
//     showToast(message: 'Your total score: $totalScore');
//     // final examination = Examination(score: totalScore, uid: user!);
//     // Examination.pushExaminationToFirebase(examination);
//   }
//
//   String formatTime(Duration position) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
//   }
//
//   Future<void> loadUser() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     setState(() {
//       user = pref.getString('auth_token');
//     });
//   }
// }
//
// class ReadingQuestionForm extends StatefulWidget {
//   final String question;
//   final List<String> answerList;
//   final Function(int) onAnswered;
//   final int groupValue;
//
//   const ReadingQuestionForm({
//     super.key,
//     required this.question,
//     required this.answerList,
//     required this.onAnswered,
//     required this.groupValue,
//   });
//
//   @override
//   _ReadingQuestionFormState createState() => _ReadingQuestionFormState();
// }
//
// class _ReadingQuestionFormState extends State<ReadingQuestionForm> {
//   int? groupValue;
//
//   @override
//   void initState() {
//     super.initState();
//     groupValue = widget.groupValue;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.question),
//           Column(
//             children: List.generate(widget.answerList.length, (index) => ListTile(
//               title: Text(widget.answerList[index]),
//               leading: SizedBox(
//                 width: 10,
//                 child: Radio<int>(
//                   value: index+1,
//                   groupValue: groupValue,
//                   onChanged: (value) {
//                     setState(() {
//                       groupValue = value;
//                     });
//                     widget.onAnswered(index+1);
//                     print('Answered: ${index+1}');
//                   },
//                 ),
//               ),
//             ),),
//           )
//         ],
//       ),
//     );
//   }
// }



