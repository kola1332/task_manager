// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/screens/detail/widgets/task_title.dart';
import 'package:task_manager/screens/detail/widgets/timeline/timeline_logic.dart';
import 'package:task_manager/screens/home/home.dart';

import '../task/add_task.dart';
import 'widgets/date_picker.dart';
import 'widgets/timeline/task_timeline.dart';

class DetailPage extends StatelessWidget {
  final Task task;
  int i = 0;
  DetailPage(this.task);

  @override
  Widget build(BuildContext context) {
    List<Desk>? detailList;
    if (task.desc != null) {
      TimelineEngine timelineEngine = TimelineEngine(task.desc!);
      detailList = timelineEngine.sort();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          // side: BorderSide(
          // color: Colors.black,
          // ),
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: task.btnColor,
        elevation: 0,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTask(task)));
        },
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.black,
        ),
      ),
      // backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                children: [
                  DatePicker(),
                  TaskTitle(),
                ],
              ),
            ),
          ),
          detailList == null
              ? SliverFillRemaining(
                  child: Container(
                    color: Colors.white,
                    child: const Center(
                        child: Text(
                      'No task today',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    )),
                  ),
                )
              : SliverList(
                  // ! need change
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      i++;
                      return TaskTimeline(
                        desk: detailList![index],
                        isLast: detailList.length == i ? false : true,
                      );
                    },
                    childCount: detailList.length,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 90,
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage())),
        iconSize: 20,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
          iconSize: 30,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${task.title} tasks',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'You have ${task.left} tasks for today',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
