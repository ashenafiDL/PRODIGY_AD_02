import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];

  final _hive = Hive.box('appBox');

  createInitialData() {
    // Default data
    todoList = [
      {
        'isCompleted': false,
        'priority': 1,
        'taskName': 'Adding task',
        'description':
            'You can add task by clicking on + button on top right corner'
      },
      {
        'isCompleted': false,
        'priority': 2,
        'taskName': 'Deleting task',
        'description': 'You can delete task by swiping left'
      },
      {
        'isCompleted': false,
        'priority': 3,
        'taskName': 'Toggle complete status',
        'description': 'You can toggle complete status of task by swiping right'
      },
      {
        'isCompleted': false,
        'priority': 4,
        'taskName': 'Edit task',
        'description': 'You can edit task by taping on the task'
      }
    ];
  }

  loadData() {
    todoList = _hive.get('todoList');
  }

  saveData() {
    _hive.put('todoList', todoList);
  }
}
