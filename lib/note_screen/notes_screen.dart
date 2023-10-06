// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/note_screen/home_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  void saveNote() async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    if (title == "" || body == "") {
      Get.snackbar(
        'Error',
        'All fields is reruired***',
        backgroundColor: const Color.fromARGB(255, 63, 58, 58),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
      );
    } else {
      setState(() {
        isLoading = true;
      });
      await FirebaseFirestore.instance.collection("Notes").doc().set({
        'createdAt': DateTime.now(),
        'title': title,
        'body': body,
        'UserId': userId?.uid,
      });
      Get.off(() => const MyHomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        automaticallyImplyLeading: false,
        title: const Text(
          'Make a note...',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: 'Title', border: InputBorder.none, filled: true),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'Lato'),
                maxLines: 1,
              ),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(
                  hintText: 'Body',
                  border: InputBorder.none,
                  filled: true,
                ),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Lato'),
                maxLines: null, // Allow multiple lines for the body
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // var title=titleController.text.trim();
            saveNote();
          },
          child: isLoading
              ? const CupertinoActivityIndicator(
                  color: Colors.black,
                )
              : const Icon(
                  Icons.save,
                  color: Colors.black,
                ),
          backgroundColor: Colors.yellow[700]),
    );
  }
}
