// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../home/home.dart';

class AddChapster extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  List<Task> tasksList;
  AddChapster(this.tasksList);

  @override
  State<AddChapster> createState() => _AddChapsterState();
}

class _AddChapsterState extends State<AddChapster> {
  String data = 'Имя вашей задачи';
  List<String> sections = ['Personal', 'Work', 'Health'];
  Color colorTab = const Color.fromARGB(255, 182, 255, 185);
  IconData iconChapster = Icons.person;
  Color colorIcon = Colors.green;

  void voidcolorGreen() {
    setState(() {
      colorTab = const Color.fromARGB(255, 182, 255, 185);
      colorIcon = Colors.green;
    });
  }

  void voidColorPink() {
    setState(() {
      colorTab = const Color.fromARGB(255, 255, 195, 215);
      colorIcon = Colors.pink;
    });
  }

  void voidColorBlue() {
    setState(() {
      colorTab = const Color.fromARGB(255, 173, 217, 254);
      colorIcon = Colors.blue;
    });
  }

  void voidColorAmber() {
    setState(() {
      colorTab = const Color.fromARGB(255, 254, 246, 171);
      colorIcon = const Color.fromARGB(255, 234, 211, 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = [];
    Item item = Item('', '', Colors.red, '');
    Map<String, dynamic> newDesk = {};
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
      body: Container(decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'http://2.bp.blogspot.com/-71RcIkmOttQ/UFS4f7e5i0I/AAAAAAAAEMo/7yGk6nPIUA0/s1600/m44portada2.jpg'),
          fit: BoxFit.cover
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                height: 250,
                width: 250,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: Icon(
                        iconChapster,
                        size: 45,
                        color: colorIcon,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 25),
                      child: TextField(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 27, 27, 27),
                          fontSize: 20,
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
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        Container(
                          width: 65,
                          height: 35,
                          decoration: BoxDecoration(
                            color: colorIcon,
                            // border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: colorIcon.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 12,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 12, top: 9),
                            child: Text('0 left'),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 65,
                          height: 35,
                          decoration: BoxDecoration(
                            color: colorTab,
                            // border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: colorIcon.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 12,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 12, top: 9),
                            child: Text('0 done'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                        height: 600,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Icon:',
                                  style: TextStyle(fontSize: 22),
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        iconChapster = Icons.call;
                                      });
                                    },
                                    child: const Icon(Icons.call)),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        iconChapster = Icons.shopping_cart;
                                      });
                                    },
                                    child: const Icon(Icons.shopping_cart)),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        iconChapster = Icons.school;
                                      });
                                    },
                                    child: const Icon(Icons.school)),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        iconChapster = Icons.business_center;
                                      });
                                    },
                                    child: const Icon(Icons.business_center)),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        iconChapster = Icons.person;
                                      });
                                    },
                                    child: const Icon(Icons.person)),
                              ],
                            ),
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
                                        color: Colors.yellow,
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
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [],
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
                                    // r.desc!.add(newDesk);
                                  }
                                }
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage()));
                              },
                              child: const Text('Cоздать'),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
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
