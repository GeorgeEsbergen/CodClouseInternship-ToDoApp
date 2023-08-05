import 'package:flutter/material.dart';

class MainTextFormField extends StatelessWidget {
  const MainTextFormField({
    super.key,

    required this.controller,
    required this.hint,
    required this.lines,
  });


  final TextEditingController controller;
  final int lines;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.white,

        maxLines: lines,
        controller: controller,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.white),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
