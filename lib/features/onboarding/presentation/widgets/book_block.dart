import 'package:flutter/material.dart';

class BookBlock extends StatelessWidget {
  const BookBlock({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}