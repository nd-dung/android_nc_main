import 'dart:async';

import 'package:english_learning/Pages/Login.dart';
import 'package:english_learning/Pages/LoginOptions.dart';
import 'package:english_learning/global/sessions/SessionsManager.dart';
import 'package:english_learning/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  bool isLoading = false;
  bool isSingOut = true;
  late String? user = '';

  Future<void> loadUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user = pref.getString('auth_token');
    });
  }

  @override
  void initState() {
    loadUser();
    print(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!),
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  await GoogleSignIn().signOut();
                  FirebaseAuth.instance.signOut();
                  // SessionManager sm=SessionManager();
                  // sm.clearAll();
                  setState(() {
                    isLoading = true;
                  });
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginOptions()),
                        (route) => false);
                  });
                },
                child: Text('Đăng xuất'),
              ),
      ),
    );
  }
}
