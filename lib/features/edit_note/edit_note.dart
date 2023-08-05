import 'package:flutter/material.dart';
import '../../core/utils/back_ground.dart';
import '../../core/utils/buttons.dart';
import '../../core/utils/text_field.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class EditNotes extends StatefulWidget {
  final String title;
  final String content;
  final String id;
  const EditNotes(
      {super.key,
      required this.title,
      required this.content,
      required this.id});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  // ignore: non_constant_identifier_names
  final Key1 = GlobalKey<FormState>();
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  @override
  void initState() {
    titleController = TextEditingController(text: widget.title);
    contentController = TextEditingController(text: widget.content);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void editNote() async {
    try {
      await FirebaseFirestore.instance
          .collection("Notes")
          .doc(widget.id)
          .update({
        "title": titleController.text.trim(),
        "content": contentController.text.trim(),
      });

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseException {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Can't Edit")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1d3a86),
          title: const Text("Edit Note"),
          centerTitle: true,
        ),
        body: Stack(
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
                  fn: editNote,
                  text: 'Edit Note',
                )
              ],
            )
          ],
        ));
  }
}
