import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/utils/back_ground.dart';
import '../../core/utils/buttons.dart';
import '../../core/utils/text_field.dart';

class NewNoteBody extends StatefulWidget {
  const NewNoteBody({super.key});

  @override
  State<NewNoteBody> createState() => _NewNoteBodyState();
}

class _NewNoteBodyState extends State<NewNoteBody> {
  // ignore: non_constant_identifier_names
  final Key1 = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();


  void addNote() async {
    
      try {
        await FirebaseFirestore.instance.collection("Notes").add({
          "title": titleController.text.trim(),          
          "content": contentController.text.trim(),
        });

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } on FirebaseException {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Can't connect to firebase")));
      }
    
  }



  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackGround(),
        ListView(
          children: [
            const SizedBox(height: 20),
            Form(
                key: Key1,
                child: Column(
                  children: [
                    MainTextFormField(
                      controller: titleController,
                      
                      hint: 'title',
                      lines: 1,
                    ),
                    const SizedBox(height: 20),
                    MainTextFormField(
                      controller: contentController,
                      
                      hint: 'Content',
                      lines: 15,
                    ),
                  ],
                )),
            const SizedBox(height: 40),
            MainButton(
              fn: addNote,
              text: 'Add Note',
            )
          ],
        )
      ],
    );
  }
}
