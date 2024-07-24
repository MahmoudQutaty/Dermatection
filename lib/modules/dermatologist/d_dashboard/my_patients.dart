import 'package:flutter/material.dart';

class MyPatients extends StatefulWidget {
  const MyPatients({Key? key}) : super(key: key);

  @override
  State<MyPatients> createState() => _MyPatientsState();
}

class _MyPatientsState extends State<MyPatients> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('My Patients Page'),);
  }
}
