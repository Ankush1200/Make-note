// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp/manage_user/login_page.dart';
import 'package:notesapp/note_screen/edit_screen.dart';
import 'package:notesapp/note_screen/notes_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  User? userId = FirebaseAuth.instance.currentUser;
  
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.off(
      () => const LoginPage(),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NotesApp',
          style: TextStyle(color: Colors.black,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.yellow[700],
        actions: [
          IconButton(
            onPressed: () {
              showDialog(context: context, builder:(context)=>const AlertDialog(
                title: Text('Intructions.....📝',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
                ),
                content: Text('1. To create a new note just tap on the plus Icon(+) it will redirect you on a fresh page where you able to create a fresh note...\n\n2. To See/Edit note just tap on the desired note you want to see/Edit...\n\n3. To delete any note just press and hold the desired note it will automataclly deleted...',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              );
            },
            icon: const Icon(
              // islistviev ? Icons.splitscreen_rounded : Icons.grid_view,
              // color: Colors.black,
              Icons.integration_instructions,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(Icons.logout),
            color: Colors.black,
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Notes")
              .where("UserId", isEqualTo: userId?.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong...!"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: SizedBox(
                    height: 200,
                    child: Lottie.asset('assets/animation_ln8piufw.json')),
              );
            }
            // ignore: unnecessary_null_comparison
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                    // color: const Color.fromARGB(255, 235, 235, 227),
                  
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical:5),
                        child: Text(
                          snapshot.data!.docs[index]["title"],
                          style: const TextStyle(fontSize: 16,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data!.docs[index]["body"],
                        style: const TextStyle(fontSize: 15,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        // color: Colors.white
                        ),
                        maxLines: 5,
                      ),
                      onTap:(){
                        Get.to(()=>const EditScreen(),
                        arguments: {
                          'title':snapshot.data!.docs[index]["title"],
                          'body':snapshot.data!.docs[index]["body"],
                          'docId':snapshot.data!.docs[index].id,
                        }
                        );
                      },
                      onLongPress:(){
                        FirebaseFirestore.instance.collection('Notes').doc(snapshot.data!.docs[index].id).delete();
                      }
                      // trailing: IconButton(onPressed:(){},icon: const Icon(Icons.delete), ),
                    ),
                  );
                },
              );
            }
            return const CupertinoActivityIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const NotesScreen());
        },
        // ignore: sort_child_properties_last
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.yellow[700],
      ),
    );
  }
}
