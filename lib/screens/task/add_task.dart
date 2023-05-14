// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/screens/detail/detail.dart';

import '../../bloc/task_cubit.dart';
import '../../bloc/task_state.dart';
import '../../models/task.dart';
import '../detail/widgets/date_picker.dart';

class AddTask extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  final Task task;

  AddTask(this.task);

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
        // newDesk.time = newTime.format(context);
        newDesk.newTime = newTime;
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
    newDesk = Desk(title: '');
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

      final List<DropdownMenuEntry<Chapter>> tasksEntry =
          <DropdownMenuEntry<Chapter>>[];
      // Chapter chapter = Chapter(widget.task.title!);
      int indexChap = 0;

      for (int i = 0;i < tasksList.length; i++ ) {
        if (tasksList[i].title != null) {
          tasksEntry.add(DropdownMenuEntry<Chapter>(
            value: Chapter(tasksList[i].title!),
            label: tasksList[i].title!,
          ));
          if(widget.task.title == tasksList[i].title) {
            indexChap = i;
          }
        }
      }
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

      return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 0,
        ),
        backgroundColor: Colors.white,
        // body: Container(
        //   decoration: const BoxDecoration(
        //     // image: DecorationImage(
        //     //     image: ExactAssetImage('assets/space.jpg'),
        //     //     //  NetworkImage(
        //     //     //     'http://2.bp.blogspot.com/-71RcIkmOttQ/UFS4f7e5i0I/AAAAAAAAEMo/7yGk6nPIUA0/s1600/m44portada2.jpg'),
        //     //     fit: BoxFit.cover),
        //   ),
        body: SafeArea(
          child: ListView(
            children: [
              _buildPresentationContainer(context),
              // const SizedBox(height: 7),
              Container(
                  // height: 70,
                  // decoration: const BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(40),
                  //       topRight: Radius.circular(40)),
                  // ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DatePicker(),
                      _buildColor(),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DropdownMenu<Chapter>(
                              width: 150,
                              dropdownMenuEntries: tasksEntry,
                              enableSearch: false,
                              label: const Text("Раздел"),
                              initialSelection: tasksEntry[indexChap].value,
                              onSelected: (value) {
                                // ! CHAPTER
                                newDesk.chap = value!;
                              }),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // ! FINISH
                          const errorTitle = SnackBar(
                            content: Text('Введите название задачи'),
                          );
                          // const errorChapter = SnackBar(
                          //   content: Text('Введите раздел'),
                          // );
                          const errorTime = SnackBar(
                            content: Text('Введите время'),
                          );
                          Task task = Task();
                          if (newDesk.title == '') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(errorTitle);
                          // } else if (newDesk.chap == null) {
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(errorChapter);
                            } else if (newDesk.newTime == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(errorTime);
                          } else {
                            newDesk.chap ??= tasksEntry[indexChap].value;
                            if (state is TaskStateLoaded) {
                              for (var taskChap in state.tasks) {
                                if (taskChap.title == newDesk.chap!.label) {
                                  taskChap.desc ??= [];
                                  taskChap.desc!.add(newDesk);
                                  task = taskChap;
                                }
                              }
                            }
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Detailpage(task)));
                            // Navigator.pop(context);
                          }
                        },
                        child: const Text('Готово'),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      );
      // );
    });
  }

  Row _buildColor() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          'Color:',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              colorTab = Colors.cyan;
            });
            newDesk.bgColor = Colors.cyan;
          },
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                color: Colors.cyan, borderRadius: BorderRadius.circular(50)),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              colorTab = Colors.blue;
            });
            newDesk.bgColor = Colors.blue;
          },
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(50)),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              colorTab = Colors.pinkAccent;
            });
            newDesk.bgColor = Colors.pinkAccent;
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
            newDesk.bgColor = Colors.green;
          },
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ],
    );
  }

  AnimatedContainer _buildPresentationContainer(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
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
                  border: InputBorder.none, hintText: "Имя вашей задачи"),
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
              const Column(
                children: [
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
    );
  }
}

class Chapter {
  final String label;
  Chapter(this.label);
}
