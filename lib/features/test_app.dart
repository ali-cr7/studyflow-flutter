import 'package:flutter/material.dart';

class TestUI extends StatelessWidget {
  const TestUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test App')),
      body: Center(child: Text('Hello, World!')),
    );
  }
}
