import 'package:flutter/material.dart';

class PersonalAssistant extends StatefulWidget {
  const PersonalAssistant({super.key});

  @override
  State<PersonalAssistant> createState() => _PersonalAssistantState();
}

class _PersonalAssistantState extends State<PersonalAssistant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CustomSupport'),),
    );
  }
}