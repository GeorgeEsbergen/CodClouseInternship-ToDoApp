import 'package:flutter/material.dart';

import 'new_note_body.dart';

class NewNote extends StatelessWidget {
  const NewNote({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1d3a86),
        title: const Text("Add New Note"),
        centerTitle: true,
      ),
      body: const NewNoteBody(),
    );
  }
}