import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/data/database.dart';
import 'package:todo_list/widgets/add_task_dialog.dart';
import 'package:todo_list/widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _hive = Hive.box('appBox');
  final TodoDatabase _db = TodoDatabase();

  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();

  void onAdd() {
    setState(() {
      _db.todoList.add({
        'isCompleted': false,
        'priority': 1,
        'taskName': _taskNameController.text,
        'description': _taskDescriptionController.text
      });
      _taskNameController.clear();
      _taskDescriptionController.clear();
    });
    Navigator.of(context).pop();
    _db.saveData();
  }

  void onUpdate(int index, String name, String description) {
    setState(() {
      _db.todoList[index]['taskName'] = name;
      _db.todoList[index]['description'] = description;
    });
    _db.saveData();
  }

  handleChange(bool? value, int index) {
    setState(() {
      _db.todoList[index]['isCompleted'] = value!;
    });
    _db.saveData();
  }

  @override
  void initState() {
    if (_hive.get('todoList') == null) {
      _db.createInitialData();
    } else {
      _db.loadData();
    }
    super.initState();
  }

  onCreateTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddNewTaskDialog(
          taskNameController: _taskNameController,
          taskDescriptionController: _taskDescriptionController,
          onAdd: onAdd,
        );
      },
    );
  }

  onDeleted(int index) {
    setState(() {
      _db.todoList.removeAt(index);
    });
    _db.saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: _db.todoList.length,
        itemBuilder: (context, index) {
          return TodoItem(
            isCompleted: _db.todoList[index]['isCompleted'],
            taskName: _db.todoList[index]['taskName'],
            description: _db.todoList[index]['description'],
            onChanged: (value) => handleChange(value, index),
            onDeleted: (context) => onDeleted(index),
            onUpdate: onUpdate,
            index: index,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
