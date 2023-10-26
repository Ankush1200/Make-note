import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp/manage_user/login_page.dart';
import 'package:notesapp/note_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  User?user=FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(
          seconds: 3,
        ), () {
      Get.offAll(user!=null?const MyHomePage():const LoginPage());
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[700],
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: Lottie.asset('assets/animation_lnkplb0m.json')),
          const Padding(
            padding: EdgeInsets.symmetric(vertical:20.0),
            child: Text('A Notes App by Ankush Prajapati',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              color:Colors.black,
            ),),
          )
        ],
      ),
    );
  }
}
