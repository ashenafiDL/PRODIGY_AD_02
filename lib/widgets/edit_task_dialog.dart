import 'package:flutter/material.dart';

class EditTaskDialog extends StatelessWidget {
  const EditTaskDialog({
    super.key,
    required this.taskNameController,
    required this.taskDescriptionController,
    required this.onSave,
  });

  final TextEditingController taskNameController;
  final TextEditingController taskDescriptionController;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: taskNameController,
            decoration: const InputDecoration(
              labelText: 'Task Name',
            ),
          ),
          TextField(
            controller: taskDescriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
