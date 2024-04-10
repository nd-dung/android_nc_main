// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uuid/uuid.dart';
// class Examination {
//   String uid;
//   int score;
//
//   Examination({required this.score,required this.uid});
//
//   Map<String, dynamic> toFirebase() {
//     return {
//       'uid': uid,
//       'score': score,
//     };
//   }
//
//   static Examination fromFirebase(Map<String, dynamic> firebase) {
//     return Examination(
//       uid: firebase['uid'],
//       score: firebase['score'],
//     );
//   }
//
//   static  Future<void> pushExaminationToFirebase(Examination examination) async {
//     await FirebaseFirestore.instance.collection('examinations').doc(examination.uid).collection('score').doc().set(examination.toFirebase());
//   }
//   static Future<Examination> getExaminationFromFirebase(String uid) async {
//     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('examinations').doc(uid).collection('score').doc().get();
//     return Examination.fromFirebase(documentSnapshot.data() as Map<String, dynamic>);
//   }
//
// }