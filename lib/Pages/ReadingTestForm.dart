import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learning/Models/TestFormModels.dart';
import 'package:english_learning/Models/Users_ThiDocModels.dart';
import 'package:english_learning/Pages/CT_Reading.dart';
import 'package:english_learning/Pages/ResultForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingTestForm extends StatefulWidget {
  String? made;

  ReadingTestForm({required this.made});

  @override
  State<StatefulWidget> createState() => _ReadingTestForm();
}

class _ReadingTestForm extends State<ReadingTestForm> {
  bool isLoading = false;
  int tongdiem = 0;
  String? getMaDe;
  List<TestFormModels> lstTest = [];
  var index = 0;
  late String? user = '';

  // var cauTheoMaDe;
  void initState() {
    _loadData();
    loadUser();
    super.initState();
  }

  Future<void> loadUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user = pref.getString('auth_token');
    });
  }

  Future _loadData() async {
    getMaDe = widget.made;
    final cauTheoMaDe = await FirebaseFirestore.instance
        .collection('CT_ThiDoc')
        .where('made', isEqualTo: getMaDe!)
        .get();
    if (cauTheoMaDe.docs.isNotEmpty) {
      cauTheoMaDe.docs.forEach((element) {
        lstTest.add(new TestFormModels(
            made: element['made'],
            question: element['question'],
            A: element['A'],
            B: element['B'],
            C: element['C'],
            D: element['D'],
            awnser: element['awnser']));
      });
    }
    setState(() {});
  }

  Future _updateDiem(
      String? user, String made, String diem, String solanlam) async {
    final idTest = user.toString() + '_' + made;
    final userTest = await FirebaseFirestore.instance
        .collection('Users_ThiDoc')
        .where('id', isEqualTo: idTest)
        .get();

    if (userTest.docs.isNotEmpty) {
      Users_ThiDocModels newUpdateTest = Users_ThiDocModels(
          id: idTest, diem: diem, solanlam: solanlam, email: user.toString());
      _updateResult(newUpdateTest, idTest);
    } else {
      Users_ThiDocModels newTest = Users_ThiDocModels(
          id: idTest, diem: diem, solanlam: solanlam, email: user.toString());
      _createResult(newTest, idTest);
    }
  }

  void _updateResult(Users_ThiDocModels users_thiDocModels, String idTest) {
    final testCollection =
    FirebaseFirestore.instance.collection('Users_ThiDoc');

    String id = idTest;

    final newTest = Users_ThiDocModels(
        id: users_thiDocModels.id,
        diem: users_thiDocModels.diem,
        solanlam: users_thiDocModels.solanlam,
        email: users_thiDocModels.email)
        .toJSON();

    testCollection.doc(id).update(newTest);
  }

  void _createResult(Users_ThiDocModels users_thiDocModels, String idTest) {
    final testCollection =
    FirebaseFirestore.instance.collection('Users_ThiDoc');

    String id = idTest;

    final newTest = Users_ThiDocModels(
        id: users_thiDocModels.id,
        diem: users_thiDocModels.diem,
        solanlam: users_thiDocModels.solanlam,
        email: users_thiDocModels.email)
        .toJSON();

    testCollection.doc(id).set(newTest);
  }

  @override
  String warningText = '';
  int selectedOption = 0;

  @override
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text('GOOD LUCK!'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(lstTest.length == 0
                    ? 'Đang tải'
                    : lstTest[index].question),
                ListTile(
                  title: Text(lstTest.length == 0
                      ? 'Đang tải'
                      : lstTest[index].A),
                  leading: Radio<int>(
                    value: 1,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                        print("Button value: $value");
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(lstTest.length == 0
                      ? 'Đang tải'
                      : lstTest[index].B),
                  leading: Radio<int>(
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                        print("Button value: $value");
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(lstTest.length == 0
                      ? 'Đang tải'
                      : lstTest[index].C),
                  leading: Radio<int>(
                    value: 3,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                        print("Button value: $value");
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(lstTest.length == 0
                      ? 'Đang tải'
                      : lstTest[index].D),
                  leading: Radio<int>(
                    value: 4,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                        print("Button value: $value");
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(warningText),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (selectedOption == 0) {
                        setState(() {
                          warningText = 'Hãy chọn 1 câu trả lời nhé!';
                        });
                      } else {
                        setState(() {
                          print('Bạn chọn $selectedOption');
                          print(lstTest[index].awnser);

                          if (selectedOption ==
                              int.parse(lstTest[index].awnser)) {
                            setState(() {
                              warningText =
                              'Bạn đã trả lời đúng! Chúc mừng!';
                              tongdiem++;
                            });
                            Future.delayed(Duration(milliseconds: 900),
                                    () {
                                  setState(() {
                                    if (index == lstTest.length - 1) {
                                      String? made = this.getMaDe;
                                      String user = this.user!;

                                      _updateDiem(user, made!,
                                          tongdiem.toString(), 1.toString());
                                      setState(() {
                                        isLoading = true;
                                      });
                                      Future.delayed(Duration(seconds: 1),
                                              () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResultForm(
                                                            total: lstTest.length,
                                                            result: tongdiem)),
                                                    (route) => false);
                                          });
                                    } else {
                                      index++;
                                    }
                                    selectedOption = 0;
                                    warningText = '';
                                  });
                                });
                          } else {
                            setState(() {
                              warningText = 'Bạn đã trả lời sai! :<';
                            });
                            Future.delayed(Duration(milliseconds: 900),
                                    () {
                                  setState(() {
                                    if (index == lstTest.length - 1) {
                                      String? made = this.getMaDe;
                                      String user = this.user!;

                                      _updateDiem(user, made!,
                                          tongdiem.toString(), 1.toString());
                                      setState(() {
                                        isLoading = true;
                                      });
                                      Future.delayed(Duration(seconds: 1),
                                              () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResultForm(
                                                            total: lstTest.length,
                                                            result: tongdiem)),
                                                    (route) => false);
                                          });
                                    } else {
                                      index++;
                                    }
                                    selectedOption = 0;
                                    warningText = '';
                                  });
                                });
                          }
                        });
                      }
                    },
                    child: Text('Kiểm tra'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

























// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:english_learning/Models/TestFormModels.dart';
// import 'package:english_learning/Models/Users_ThiDocModels.dart';
// import 'package:english_learning/Pages/CT_Reading.dart';
// import 'package:english_learning/Pages/ResultForm.dart';
// import 'package:english_learning/global/common/toast.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timer_count_down/timer_controller.dart';
// import 'package:timer_count_down/timer_count_down.dart';
//
// class ReadingTestForm extends StatefulWidget {
//   String? made;
//
//   ReadingTestForm({required this.made});
//
//   @override
//   State<StatefulWidget> createState() => _ReadingTestForm();
// }
//
// class _ReadingTestForm extends State<ReadingTestForm> {
//   bool isLoading = false;
//   int tongdiem = 0;
//   String? getMaDe;
//   List<TestFormModels> lstTest = [];
//   var index = 0;
//   late String? user = '';
//
//   //Todo: trình điều khiển thời gian
//   final countdownController = CountdownController(autoStart: true);
//
//   // var cauTheoMaDe;
//   void initState() {
//     _loadData();
//     loadUser();
//     super.initState();
//   }
//
//   Future<void> loadUser() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     setState(() {
//       user = pref.getString('auth_token');
//     });
//   }
//
//   Future _loadData() async {
//     getMaDe = widget.made;
//     final cauTheoMaDe = await FirebaseFirestore.instance
//         .collection('CT_ThiDoc')
//         .where('made', isEqualTo: getMaDe!)
//         .get();
//     if (cauTheoMaDe.docs.isNotEmpty) {
//       cauTheoMaDe.docs.forEach((element) {
//         lstTest.add(TestFormModels(
//             made: element['made'],
//             question: element['question'],
//             A: element['A'],
//             B: element['B'],
//             C: element['C'],
//             D: element['D'],
//             awnser: element['awnser']));
//       });
//       //Todo: trộn câu hỏi
//       lstTest.shuffle();
//     }
//     setState(() {});
//   }
//
//   Future _updateDiem(
//       String? user, String made, String diem, String solanlam) async {
//     final idTest = user.toString() + '_' + made;
//     final userTest = await FirebaseFirestore.instance
//         .collection('Users_ThiDoc')
//         .where('id', isEqualTo: idTest)
//         .get();
//
//     if (userTest.docs.isNotEmpty) {
//       Users_ThiDocModels newUpdateTest = Users_ThiDocModels(
//           id: idTest, diem: diem, solanlam: solanlam, email: user.toString());
//       _updateResult(newUpdateTest, idTest);
//     } else {
//       Users_ThiDocModels newTest = Users_ThiDocModels(
//           id: idTest, diem: diem, solanlam: solanlam, email: user.toString());
//       _createResult(newTest, idTest);
//     }
//   }
//
//   void _updateResult(Users_ThiDocModels users_thiDocModels, String idTest) {
//     final testCollection =
//         FirebaseFirestore.instance.collection('Users_ThiDoc');
//
//     String id = idTest;
//
//     final newTest = Users_ThiDocModels(
//             id: users_thiDocModels.id,
//             diem: users_thiDocModels.diem,
//             solanlam: users_thiDocModels.solanlam,
//             email: users_thiDocModels.email)
//         .toJSON();
//
//     testCollection.doc(id).update(newTest);
//   }
//
//   void _createResult(Users_ThiDocModels users_thiDocModels, String idTest) {
//     final testCollection =
//         FirebaseFirestore.instance.collection('Users_ThiDoc');
//
//     String id = idTest;
//
//     final newTest = Users_ThiDocModels(
//             id: users_thiDocModels.id,
//             diem: users_thiDocModels.diem,
//             solanlam: users_thiDocModels.solanlam,
//             email: users_thiDocModels.email)
//         .toJSON();
//
//     testCollection.doc(id).set(newTest);
//   }
//
//   @override
//   String warningText = '';
//   int selectedOption = 0;
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const Center(
//             child: CircularProgressIndicator(),
//           )
//         : Scaffold(
//             appBar: AppBar(
//               title: Text('GOOD LUCK!'),
//               centerTitle: true,
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Countdown(
//                     seconds: 10,
//                     build: (_, time) {
//                       return Text(
//                         time.toString(),
//                         style: const TextStyle(fontSize: 17),
//                       );
//                     },
//                     onFinished: () {
//                       _handleReadingTest(context);
//                     },
//                     controller: countdownController,
//                   ),
//                 )
//               ],
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SingleChildScrollView(
//                 child: Center(
//                   child: Column(
//                     children: <Widget>[
//                       Text(lstTest.length == 0
//                           ? 'Đang tải'
//                           : lstTest[index].question),
//                       ListTile(
//                         title: Text(lstTest.length == 0
//                             ? 'Đang tải'
//                             : lstTest[index].A),
//                         leading: Radio<int>(
//                           value: 1,
//                           groupValue: selectedOption,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedOption = value!;
//                               print("Button value: $value");
//                             });
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         title: Text(lstTest.length == 0
//                             ? 'Đang tải'
//                             : lstTest[index].B),
//                         leading: Radio<int>(
//                           value: 2,
//                           groupValue: selectedOption,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedOption = value!;
//                               print("Button value: $value");
//                             });
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         title: Text(lstTest.length == 0
//                             ? 'Đang tải'
//                             : lstTest[index].C),
//                         leading: Radio<int>(
//                           value: 3,
//                           groupValue: selectedOption,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedOption = value!;
//                               print("Button value: $value");
//                             });
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         title: Text(lstTest.length == 0
//                             ? 'Đang tải'
//                             : lstTest[index].D),
//                         leading: Radio<int>(
//                           value: 4,
//                           groupValue: selectedOption,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedOption = value!;
//                               print("Button value: $value");
//                             });
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Text(warningText),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       ElevatedButton(
//                           onPressed: () {
//                             _handleReadingTest(context);
//                           },
//                           child: Text('Kiểm tra'))
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//   }
//
//   //Todo: tách ra làm hàm riêng để tái sử dụng
//   void _handleReadingTest(BuildContext context) {
//     Future.delayed(Duration(milliseconds: 900), () {
//       setState(() {
//         if (index == lstTest.length - 1) {
//           String? made = this.getMaDe;
//           String user = this.user!;
//           _updateDiem(user, made!, tongdiem.toString(), 1.toString());
//           setState(() {
//             isLoading = true;
//           });
//           Future.delayed(Duration(seconds: 1), () {
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         ResultForm(total: lstTest.length, result: tongdiem)),
//                 (route) => false);
//           });
//         }
//         selectedOption = 0;
//         warningText = '';
//       });
//     });
//     if (selectedOption == 0) {
//       setState(() {
//         showToast(
//           message: 'Bạn chưa chọn đáp án!',
//         );
//         incrementIndex();
//       });
//     } else {
//       setState(() {
//         print('Bạn chọn $selectedOption');
//         print(lstTest[index].awnser);
//         if (selectedOption == int.parse(lstTest[index].awnser)) {
//           setState(() {
//             warningText = 'Bạn đã trả lời đúng! Chúc mừng!';
//             tongdiem++;
//           });
//           Future.delayed(Duration(milliseconds: 900), () {
//             setState(() {
//               if (index == lstTest.length - 1) {
//                 String? made = this.getMaDe;
//                 String user = this.user!;
//
//                 _updateDiem(user, made!, tongdiem.toString(), 1.toString());
//                 setState(() {
//                   isLoading = true;
//                 });
//               } else {
//                 incrementIndex();
//               }
//               selectedOption = 0;
//               warningText = '';
//             });
//           });
//         } else {
//           setState(() {
//             warningText = 'Bạn đã trả lời sai! :<';
//           });
//         }
//       });
//     }
//   }
//
//   //Todo: tạo hàm trước khi tăng index phải kiểm tra xem nó có bé hơn list không
//   void incrementIndex() {
//     if (index < lstTest.length - 1) {
//       index++;
//       countdownController.restart();
//     }
//   }
// }
