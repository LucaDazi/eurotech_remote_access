import 'package:flutter/material.dart';

class CenterCard extends StatelessWidget {
  const CenterCard({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: TextStyle(fontSize: 20.0)),
        ),
      ),
    );
  }
}
