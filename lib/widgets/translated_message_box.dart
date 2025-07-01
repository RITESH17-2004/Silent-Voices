import 'package:flutter/material.dart';

class TranslatedMessageBox extends StatelessWidget {
  final String message;
  final String label;
  const TranslatedMessageBox({super.key, required this.message, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F8FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFB0BEC5)),
          ),
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
          ),
        ),
      ],
    );
  }
} 