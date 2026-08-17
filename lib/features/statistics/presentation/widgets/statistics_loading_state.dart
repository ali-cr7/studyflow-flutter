import 'package:flutter/material.dart';

class StatisticsLoadingState extends StatelessWidget {
  const StatisticsLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
