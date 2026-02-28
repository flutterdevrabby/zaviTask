import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zavisoft_task/common_widget/custom_button.dart';

class ProfileDialog extends StatelessWidget {
  final Map<String, dynamic> data;
  const ProfileDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.blue.shade100,
            child: const Icon(Icons.person, size: 40, color: Colors.blue),
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            data["name"],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),

          // Email
          Text(data["email"], style: TextStyle(color: Colors.grey)),

          const SizedBox(height: 16),

          CustomButton(
            borderSide: BorderSide(color: Colors.red),
            color: Colors.red,
            onPressed: () {
              context.pop();
            },
            text: "Back",
          ),
        ],
      ),
    );
  }
}
