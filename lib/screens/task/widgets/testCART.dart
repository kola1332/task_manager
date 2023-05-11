// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '/models/task.dart';
import '/screens/task/add_task.dart';

class Cart extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  List<Task> tasksList;
  Cart(this.tasksList);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  
  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.black,
      body: 
         Column(
           children: [Container(width: 200,
                    height: 200,
                    color: Colors.pink,),
             Container(height: 100,
               child: ListView(scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 1000,
                    height: 1000,
                    color: Colors.amber,
                  ),
                  Container(
                    width: 1000,
                    height: 1000,
                    color: Colors.blue,
                  ),Container(
                    width: 1000,
                    height: 1000,
                    color: Colors.green,
                  ),
                ]
                     ),
             ),
           ],
         ),
      
    );
  }
}
