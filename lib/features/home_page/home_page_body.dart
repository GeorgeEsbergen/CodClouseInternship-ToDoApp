import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:todo_app/core/utils/back_ground.dart';
import 'package:todo_app/features/edit_note/edit_note.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final connectionState1 =
      FirebaseFirestore.instance.collection("Notes").snapshots();

  void deleteFun(String id) async {
    await FirebaseFirestore.instance.collection("Notes").doc(id).delete();
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Note Deleted")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackGround(),
        StreamBuilder(
          stream: connectionState1,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<QueryDocumentSnapshot> document = snapshot.data!.docs;
              if (document.isEmpty) {
                return const Center(child: Text("No Notes to show"));
              } else {
                return ListView.builder(
                    itemCount: document.length,
                    itemBuilder: (context, index) {
                      final note =
                          document[index].data() as Map<String, dynamic>;
                      // ignore: unused_local_variable
                      final noteId = document[index].id;
                      return ListTile(
                          title: Text("${note["title"]}"),
                          subtitle: Text(
                            "${note["content"]} ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          trailing: SizedBox(
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => EditNotes(
                                                    title: note["title"],
                                                    content: note["content"],
                                                    id: noteId,
                                                  )));
                                    },
                                    child: const Icon(Icons.edit)),
                                GestureDetector(
                                    onTap: () {
                                      deleteFun(noteId);
                                    },
                                    child: const Icon(Icons.delete)),
                              ],
                            ),
                          ));
                    });
              }
            } else if (snapshot.hasError) {
              return const Center(child: Text("has Error"));
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
      ],
    );
  }
}
