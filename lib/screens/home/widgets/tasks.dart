import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/bloc/task_cubit.dart';
import 'package:task_manager/bloc/task_state.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/screens/detail/detail.dart';

import '../../task/add__chapster.dart';

class Tasks extends StatelessWidget {
  late final tasksList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      if (state is TaskStateLoaded) {
        tasksList = state.tasks;
      }
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GridView.builder(
            itemCount: tasksList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => tasksList[index].isLast
                ? _buildAddTask(context)
                : _buildTask(context, tasksList[index])),
      );
    });
  }

  Widget _buildAddTask(context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(20),
      dashPattern: const [10, 10],
      color: Colors.grey,
      strokeWidth: 2,
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    // Cart
                    // AddTask
                    AddChapster(tasksList)));
          },
          child: const Text(
            '+ Add',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildTask(BuildContext context, Task task) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Detailpage(task, tasksList)));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: task.bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              task.iconData,
              color: task.iconColor,
              size: 35,
            ),
            const SizedBox(height: 25),
            Text(
              task.title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildTaskStatus(
                  task.btnColor!,
                  task.iconColor!,
                  '${task.left} left',
                ),
                const SizedBox(width: 5),
                _buildTaskStatus(
                  Colors.white,
                  task.iconColor!,
                  '${task.done} done',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStatus(Color bgColor, Color txColor, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: txColor)),
    );
  }
}
