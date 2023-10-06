import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp/manage_user/login_page.dart';

class ForgetPasword extends StatefulWidget {
  const ForgetPasword({super.key});

  @override
  State<ForgetPasword> createState() => _ForgetPaswordState();
}

class _ForgetPaswordState extends State<ForgetPasword> {
TextEditingController forgetpasswordcontrolerr=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
        title:const Text('Reset Pasword',
        style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child:Lottie.asset('assets/animation_ln39hidx.json'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 10),
              child: TextFormField(
                controller: forgetpasswordcontrolerr,
                decoration:const InputDecoration(
                  hintText:'Email',
                  // filled: true,
                  // fillColor: Color.fromARGB(255, 232, 230, 230),
                  prefixIcon: Icon(Icons.email),
                  // prefixIconColor: Colors.black,
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(onPressed:() async{
                  var forgetemail=forgetpasswordcontrolerr.text.trim();
                  
                  try{
                    await FirebaseAuth.instance.sendPasswordResetEmail(email:forgetemail).then((value) => 
                    Get.to(()=>const LoginPage())
                    );

                  }
                  on FirebaseAuthException catch(e){
                    // print('$e');
                    Get.snackbar(
                      'Error',
                      e.code.toString(),
                      backgroundColor: const Color.fromARGB(255, 63, 58, 58),
                      colorText: Colors.white,
                      snackPosition:SnackPosition.TOP);
                  }
              }, 
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal:20.0,vertical: 10),
                child: Text('Reset password',
                style: TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),
                        ),
              ),
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}