import 'package:flutter/material.dart';

/// CreateDate: 2025/7/4 16:03
/// Author: Lee
/// Description:

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Text('Home Page', style: TextStyle(fontSize: 120.0))),
  );
}
