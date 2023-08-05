import 'package:flutter/material.dart';

import '../new_note/new_note.dart';
import 'home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1d3a86),
        title: const Text("To do App"),
        centerTitle: true,
      ),
      body: const HomePageBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white.withOpacity(0.7),
        onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const NewNote())),
        child: const Icon(
          Icons.edit_document,
          color: Color(0xff1d3a86),
        ),
      ),
    );
  }
}
