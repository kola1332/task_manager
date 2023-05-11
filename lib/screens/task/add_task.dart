// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/task_cubit.dart';
import '../../bloc/task_state.dart';
import '../../models/task.dart';
import '../detail/widgets/date_picker.dart';
import '../home/home.dart';

class AddTask extends StatefulWidget {
  TextEditingController controller = TextEditingController();

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TimeOfDay time1;
  late TimeOfDay time2;
  late Desk newDesk;
  String data = 'Имя вашей задачи';
  Color colorTab = Colors.green;

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time1,
    );
    if (newTime != null) {
      setState(() {
        time1 = newTime;
        newDesk.time = newTime.format(context);
      });
    }
  }

  void _selectTime2() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time2,
    );
    if (newTime != null) {
      setState(() {
        time2 = newTime;
      });
    }
  }

  @override
  void initState() {
    // ! INIT STATE
    time1 = const TimeOfDay(hour: 0, minute: 0);
    time2 = const TimeOfDay(hour: 0, minute: 0);
    newDesk = Desk(time: '00:00');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      late List<Task> tasksList;

      if (state is TaskStateLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TaskStateLoaded) {
        tasksList = state.tasks;
      }

      final List<DropdownMenuEntry<Chapsters>> tasksEntry =
          <DropdownMenuEntry<Chapsters>>[];

      for (final Task color in tasksList) {
        if (color.title != null) {
          tasksEntry.add(DropdownMenuEntry<Chapsters>(
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
                fit: BoxFit.cover),
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
                              // ! NAME
                              newDesk.title = name;
                              setState(() {
                                data = name;
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
                                // ! TIME 1
                                _selectTime();
                              },
                              child: Text(
                                time1.format(context),
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
                                // ! TIME 2
                                _selectTime2();
                              },
                              child: Text(
                                time2.format(context),
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
                  const SizedBox(height: 7),
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
                                onPressed: () {
                                  setState(() {
                                    colorTab = Colors.cyan;
                                  });
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    colorTab = Colors.blue;
                                  });
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    colorTab = Colors.pinkAccent;
                                  });
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    colorTab = Colors.green;
                                  });
                                },
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
                                  dropdownMenuEntries: tasksEntry,
                                  enableSearch: false,
                                  enableFilter: false,
                                  label: const Text("Раздел"),
                                  onSelected: (value) {
                                    // ! CHAPSTER
                                    newDesk.chap = value!.label;
                                  }),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // ! FINISH
                              if (state is TaskStateLoaded) {
                                for (var taskChap in state.tasks) {
                                  if (taskChap.title == newDesk.chap) {
                                    taskChap.desc!.add(newDesk);
                                  }
                                }
                              }
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomePage()));
                            },
                            child: const Text('Готово'),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class Chapsters {
  final String label;
  Chapsters(this.label);
}