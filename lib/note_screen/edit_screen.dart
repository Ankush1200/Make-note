// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/note_screen/home_screen.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController=TextEditingController();
  TextEditingController bodyController=TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        automaticallyImplyLeading: false,
        title: const Text(
          'Edit Your Note',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                // ignore: unnecessary_string_interpolations
                controller:titleController..text="${Get.arguments['title'].toString()}",
                decoration: const InputDecoration(
                    hintText: 'Title', border: InputBorder.none, filled: true),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'Lato'),
                maxLines: 1,
              ),
              TextField(
                // ignore: unnecessary_string_interpolations
                controller: bodyController..text="${Get.arguments['body'].toString()}",
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
          onPressed: () async{
            setState(() {
              isLoading=true;
            });
           await FirebaseFirestore.instance.collection('Notes').doc(Get.arguments['docId']).update({
            'title':titleController.text.trim(),
            'body':bodyController.text.trim(), 
           }).then((value) => Get.offAll(()=>const MyHomePage()));
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
