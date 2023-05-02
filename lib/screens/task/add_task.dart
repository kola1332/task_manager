import 'package:flutter/material.dart';

import '../../models/task.dart';

class AddTask extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  final List<Task> tasksList;
  AddTask(this.tasksList);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 0);
  String data = 'data';
  List<String> sections = ['Personal', 'Work', 'Health'];

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> newDesk = {};
    final Task newTask = Task();
    final List<DropdownMenuEntry<Chapsters>> tasks =
        <DropdownMenuEntry<Chapsters>>[];
    for (final Task color in widget.tasksList) {
      if (color.title != null) {
        tasks.add(DropdownMenuEntry<Chapsters>(
          value: Chapsters(color.title!),
          label: color.title!,
        ));
      }
    }
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data),
                TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    labelText: 'Task name',
                  ),
                  onSubmitted: (String name) {
                    setState(() {
                      data = name;
                      newDesk['title'] = name;
                    });
                  },
                  // onEditingComplete: () {
                  //   setState(() {
                  //     data = widget.controller.text;
                  //   });
                  // },
                ),
                ElevatedButton(
                  onPressed: () {
                    _selectTime();
                    newDesk['time'] = _time.toString();
                  },
                  child: const Text('Add time'),
                ),
                // TextFormField(
                //   decoration: const InputDecoration(
                //     icon: Icon(Icons.favorite),
                //     labelText: 'Task name',
                //     labelStyle: TextStyle(
                //       color: Color(0xFF6200EE),
                //     ),
                //     // helperText: 'Helper text',
                //     // suffixIcon: Icon(Icons.check_circle),
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Color(0xFF6200EE)),
                //     ),
                //   ),
                // ),
                DropdownMenu<Chapsters>(
                  dropdownMenuEntries: tasks,
                  enableSearch: false,
                  enableFilter: false,
                  label: Text('Раздел'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('${newDesk['title']} ${newDesk['time']}');
                  },
                  child: const Text('Add task'),
                ),
              ],
            )),
      )),
    );
  }
}

class Chapsters {
  final String label;
  Chapsters(this.label);
}
