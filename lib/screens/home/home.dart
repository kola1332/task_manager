import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/screens/home/widgets/go_premium.dart';
import 'package:task_manager/screens/home/widgets/tasks.dart';

import '../task/add_task.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final tasksList = Task.generateTasks();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GoPremium(),
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text(
              'Tasks',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Tasks()),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.black,
        elevation: 0,
        onPressed: () {
           Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddTask(tasksList)));
        },
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Person',
                icon: Icon(Icons.person_rounded),
              ),
            ],
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/icon_profile.png'),
            ),
          ),
          const SizedBox(width: 10),
          const Text('Hi, kola132!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
      actions: const [
        Icon(
          Icons.more_vert,
          color: Colors.black,
          size: 40,
        )
      ],
    );
  }
}
