import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/task_cubit.dart';
import '../../bloc/task_state.dart';
import '../../models/task.dart';
import '../detail/widgets/date_picker.dart';
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
  Color colorTab = Colors.green;
  void voidcolorGreen() {
    setState(() {
      colorTab = Colors.green;
    });
  }

  void voidColorPink() {
    setState(() {
      colorTab = Colors.pinkAccent;
    });
  }

  void voidColorBlue() {
    setState(() {
      colorTab = Colors.blue;
    });
  }

  void voidColorAmber() {
    setState(() {
      colorTab = Colors.cyan;
    });
  }

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
    List<dynamic> list = [];
    Item item = Item('', '', Colors.red, '');
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'http://2.bp.blogspot.com/-71RcIkmOttQ/UFS4f7e5i0I/AAAAAAAAEMo/7yGk6nPIUA0/s1600/m44portada2.jpg'),
          fit: BoxFit.cover
          ),
        ),
        child: SafeArea(
          child: Expanded(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  height: 160,
                  decoration: BoxDecoration(
                    color: colorTab,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colorTab.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 12,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 27, 27, 27),
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                          controller: widget.controller,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Имя вашей задачи"),
                          onSubmitted: (String name) {
                            setState(() {
                              data = name;
                              newDesk['title'] = name;
                              item.title = name;
                              list.add(name);
                              print('title = ${item.title}');
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20),
                          Column(
                            children: const [
                              Text(
                                'Mon',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '24',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                          TextButton(
                            onPressed: () {
                              _selectTime();
                              newDesk['time'] = _time.toString();
                              item.time = _time.format(context);
                              list.add(_time.format(context));
                              print('time = ${item.time}');
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
                              newDesk['time'] = _time2.toString();
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
                ),const SizedBox(height: 7),
                Container(
                    height: 600,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DatePicker(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Color:',
                              style: TextStyle(fontSize: 22),
                            ),
                            TextButton(
                              onPressed: voidColorAmber,
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            TextButton(
                              onPressed: voidColorBlue,
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            TextButton(
                              onPressed: voidColorPink,
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            TextButton(
                              onPressed: voidcolorGreen,
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                          ],
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
                              onSelected: (value) =>
                                  newDesk['chapster'] = value,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print(list[0]);
                            print(list[1]);
                            print('title = ${item.time}');
                            print('time = ${item.title}');
                            newDesk['chapster'];
                            for (var r in widget.tasksList) {
                              if (r.title == newDesk['chapster']) {
                                r.desc ??= [];
                                r.desc!.add(newDesk);
                              }
                            }
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    HomePage()));
                          },
                          child: const Text('Готовонах'),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
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
