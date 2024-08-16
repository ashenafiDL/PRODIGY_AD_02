import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/widgets/edit_task_dialog.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    super.key,
    required this.taskName,
    this.description,
    required this.onChanged,
    required this.onDeleted,
    required this.onUpdate,
    required this.isCompleted,
    required this.index,
  });

  final String taskName;
  final String? description;
  final Function(bool?)? onChanged;
  final void Function(BuildContext)? onDeleted;
  final void Function(int, String, String) onUpdate;
  final bool isCompleted;
  final int index;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: widget.onDeleted,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4.0),
              topLeft: Radius.circular(4.0),
            ),
          )
        ],
      ),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => widget.onChanged!(!widget.isCompleted),
            icon: widget.isCompleted ? Icons.close : Icons.done,
            backgroundColor: Colors.green,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          )
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
          ),
        ),
        child: ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              _taskNameController.text = widget.taskName;
              _taskDescriptionController.text = widget.description!;
              return EditTaskDialog(
                taskNameController: _taskNameController,
                taskDescriptionController: _taskDescriptionController,
                onSave: () {
                  widget.onUpdate(
                    widget.index,
                    _taskNameController.text,
                    _taskDescriptionController.text,
                  );
                  Navigator.of(context).pop();
                },
              );
            },
          ),
          dense: true,
          tileColor: widget.isCompleted ? Colors.grey.shade200 : null,
          horizontalTitleGap: 0.0,
          contentPadding: const EdgeInsets.all(0.0),
          leading: Checkbox(
            shape: const CircleBorder(),
            visualDensity: VisualDensity.comfortable,
            value: widget.isCompleted,
            onChanged: widget.onChanged,
          ),
          title: Text(
            widget.taskName,
            style: TextStyle(
              decoration:
                  widget.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: widget.description != null
              ? Text(
                  widget.description!,
                  style: TextStyle(
                    decoration:
                        widget.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
