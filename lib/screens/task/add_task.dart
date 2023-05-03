import 'package:flutter/material.dart';

import '../../models/task.dart';
import '../home/home.dart';

class AddTask extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  List<Task> tasksList;
  AddTask(this.tasksList);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _time2 = const TimeOfDay(hour: 0, minute: 0);
  String data = 'Имя вашей задачи';
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

  void _selectTime2() async {
    final TimeOfDay? newTime2 = await showTimePicker(
      context: context,
      initialTime: _time2,
    );
    if (newTime2 != null) {
      setState(() {
        _time2 = newTime2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Item item = Item('','',Colors.red,'');
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
                    color:
                        const Color.fromARGB(255, 7, 15, 255).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 12,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      controller: widget.controller,
                      decoration: const InputDecoration(
                          // labelText: 'name',
                          ),
                      onSubmitted: (String name) {
                        setState(() {
                          data = name;
                          newDesk['title'] = name;
                          item.title = name;
                        });
                      },
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      // Text(
                      //   '$data',
                      //   style: const TextStyle(
                      //     color: Color.fromARGB(255, 27, 27, 27),
                      //     fontSize: 26,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          _selectTime();
                          newDesk['time'] = _time.format(context);
                          item.time = _time.format(context);
                          newDesk['1'] = 0;
                          print(newDesk['time']);
                        },
                        child: Text(
                          _time.format(context),
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        '-',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _selectTime2();
                          newDesk['time2'] = _time2.toString();
                        },
                        child: Text(
                          _time2.format(context),
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
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
                          labelText: 'name',
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
                          DropdownMenu<Chapsters>(
                            width: 150,
                            dropdownMenuEntries: tasks,
                            enableSearch: false,
                            enableFilter: false,
                            label: const Text("Раздел"),
                            onSelected: (value) => newDesk['chapster'] = value,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('1 ${item.title}');
                          print('2 ${item.time}');
                          print('3 ${item.slot}');
                          print(newDesk['time']);
                          newDesk['bgColor'] = Colors.red;
                          newDesk['slot'] =
                              '${newDesk['time']} - ${newDesk['time']}';
                          for (var r in widget.tasksList) {
                            if (r.title == newDesk['chapster']) {
                              r.desc ??= [];
                              r.desc!.add(newDesk);
                            }
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(widget.tasksList)));
                        },
                        child: const Text('Готово'),
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

class Item {
  String title;
  String time;
  Color bgColor;
  String slot;
  Item(
    this.title,
    this.time,
    this.bgColor,
    this.slot,
  );
}
