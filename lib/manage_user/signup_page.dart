
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:lottie/lottie.dart';
import 'package:notesapp/manage_user/login_page.dart';


class SignUppage extends StatefulWidget {

  const SignUppage({super.key});

  @override
  State<SignUppage> createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  TextEditingController userNamecontroler=TextEditingController();
  TextEditingController userphonecontroler=TextEditingController();
  TextEditingController emailcontroler=TextEditingController();
  TextEditingController passwordcontroler=TextEditingController();
  TextEditingController confirmcontroler=TextEditingController();
  
  bool isLoading=false;
  void createAccount() async {
    String username=userNamecontroler.text.trim();
    String userphone=userphonecontroler.text.trim();
    String email=emailcontroler.text.trim();
    String password=passwordcontroler.text.trim();
    String comfirmpassword=confirmcontroler.text.trim();
    
    if(email=="" || password=="" ||username==""||userphone==""||comfirmpassword==" " ){
      Get.snackbar(
        'Error',
        'All fields is required*',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(255, 63, 58, 58),
        colorText: Colors.white,
      );
    }
    else if(password!=comfirmpassword){ 
      Get.snackbar(
        'Error',
        'Both Password Should be Same*',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(255, 63, 58, 58),
        colorText: Colors.white,
      );
    }
    else{
      try{
        // ignore: unused_local_variable
        setState(() {
          isLoading=true;
        });
        UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password) ;
        // Get.to(()=>const LoginPage());

        // print('User Created');
        
        if(userCredential.user!=null)
        {
          Get.off(()=>const LoginPage(),);
          
        }
      } on FirebaseAuthException catch(e){
        print(e.code.toString());
      }
     // ignore: unused_local_variable
    }
    FirebaseFirestore.instance.collection("User").doc().set({
      'username':username,
      'phone':userphone,
      'Email':email,
    }); 
    print("Data Stored");  
  }

  
  @override   
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height:200,
              child: Lottie.asset('assets/animation_ln39hidx.json'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical:10),
              child: TextFormField(
                controller: userNamecontroler,
                decoration:const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  // prefixIconColor: Colors.black,
                  hintText: 'User Name',
                  filled: true,
                  // fillColor:Color.fromARGB(255, 232, 230, 230),
                  border: OutlineInputBorder(),
                ),
                // style: const TextStyle(
                //   color: Colors.black
                // ),
                style: const TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical:10),
              child: TextFormField(
                controller: userphonecontroler,
                decoration:const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  // prefixIconColor: Colors.black,
                  hintText: 'Phone',
                  filled: true,
                  // fillColor:Color.fromARGB(255, 232, 230, 230),
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),
                // style: const TextStyle(
                //   color: Colors.black
                // ),
                keyboardType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical:10),
              child: TextFormField(
                controller: emailcontroler,
                decoration:const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  // prefixIconColor: Colors.black,
                  hintText: 'Email',
                  filled: true,
                  // fillColor:Color.fromARGB(255, 232, 230, 230),
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),
                // style: const TextStyle(
                //   color: Colors.black
                // ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
          
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical:10),
              child: TextFormField(
                controller: passwordcontroler,
                decoration:const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  // prefixIconColor: Colors.black,
                  hintText: 'Password',
                  filled: true,
                  // fillColor:Color.fromARGB(255, 232, 230, 230),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),
                // style: const TextStyle(
                //   color: Colors.black
                // ),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: TextFormField(
                controller:confirmcontroler,
                decoration:const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  // prefixIconColor: Colors.black,
                  hintText: 'Confirm Password',
                  filled: true,
                  // fillColor:Color.fromARGB(255, 232, 230, 230),
                  border:OutlineInputBorder(),
                  suffixIconColor:Colors.grey,
                ),
                style: const TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),
                // style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              createAccount();
              // var name=userNamecontroler.text.trim();
              // var phone=userphonecontroler.text.trim();
              // var email=emailcontroler.text.trim();
              // var password=passwordcontroler.text.trim();
              // var comfirmpassword=confirmcontroler.text.trim();

              // FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) => 
              // {
              //   FirebaseFirestore
                
              // });

            }, child:Padding(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical:12),
              child: isLoading?const CupertinoActivityIndicator(): const Text('Register',
              style: TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

