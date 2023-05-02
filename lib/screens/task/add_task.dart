import 'package:flutter/material.dart';

import '../../models/task.dart';

class AddTask extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  List<Task> tasksList;
  AddTask(this.tasksList);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 0);
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
    // final Task newTask = Task();
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
      child: Expanded(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              height: 140,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 85, 111, 239),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 7, 15, 255).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 12,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$data',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 27, 27, 27),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '$_time',
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$_time',
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _selectTime();
                              newDesk['time'] = _time.toString();
                            },
                            child: const Text('Время'),
                          ),
                          DropdownMenu<Chapsters>(
                            width: 150,
                            dropdownMenuEntries: tasks,
                            enableSearch: false,
                            enableFilter: false,
                            label: const Text("Раздел"),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Готовонах'),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}

class Chapsters {
  final String label;
  Chapsters(this.label);
}
