import 'package:flutter/material.dart';


import '../../shared/components/components.dart';
import '../../shared/components/const.dart';

class NewTaskScreen extends StatelessWidget {
  // Center(
  // child: Text(
  // 'New Tasks',
  // style: TextStyle(
  // color: Colors.grey,
  // fontWeight: FontWeight.bold,
  // fontSize: 30,
  // ),
  // ),
  // );
  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context, index) =>  taskwidget(tasks[index]),
        separatorBuilder: (context,index)=>Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 9,
            start: 14,
            end: 14,
          ),
          child: Container(
            height: 2,
// width: double.infinity,
            color: Colors.grey[400],
          ),
        ),
        itemCount: tasks.length,
    );
  }
}
