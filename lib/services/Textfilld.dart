import 'package:flutter/material.dart';

class Textfilldes extends StatefulWidget {
  const Textfilldes({super.key});

  @override
  State<Textfilldes> createState() => _TextfilldesState();
}

class _TextfilldesState extends State<Textfilldes> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: const TextField(),
      ),
    );
  }
}
