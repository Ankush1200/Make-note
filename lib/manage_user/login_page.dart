import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp/manage_user/forget_pasword.dart';
import 'package:notesapp/note_screen/home_screen.dart';
import 'package:notesapp/manage_user/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();

  bool isLoading = false;
  void login() async {
    String email = emailcontroler.text.trim();
    String password = passwordcontroler.text.trim();

    if (email == "" || password == "") {
      Get.snackbar(
        'Error',
        'All fields is required*',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(255, 63, 58, 58),
        colorText: Colors.white,
      );
    } else {
      try {
        setState(() {
          isLoading = true;
        });
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (userCredential.user != null) {
          Get.off(
            () => const MyHomePage(),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred.';

        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Invalid email address.';
        }
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color.fromARGB(255, 63, 58, 58),
          colorText: Colors.white,
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        centerTitle: true,
        title: const Text(
          'Login',
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
              height: 250,
              child: Lottie.asset('assets/animation_ln39hidx.json'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                controller: emailcontroler,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  // prefixIconColor: Colors.black,
                  hintText: 'Email',
                  filled: true,
                  // fillColor: Color.fromARGB(255, 232, 230, 230),
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),
                // style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                controller: passwordcontroler,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  // prefixIconColor: Colors.black,
                  hintText: 'Password',
                  filled: true,
                  // fillColor: Color.fromARGB(255, 232, 230, 230),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  
                  // suffixIconColor: Colors.grey,
                ),
                // style: const TextStyle(color: Colors.black),
                style: const TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: isLoading
                  ? const CupertinoActivityIndicator()
                  : const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Text('Login',
                      style: TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const SignUppage(),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: Card(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text('don\'t have an acount ?',
                        style: TextStyle(fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(const ForgetPasword(),);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical:10.0),
                    child: Card(child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical:10),
                      child: Text('forget passworrd',
                      style: TextStyle(fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,),),
                    ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
