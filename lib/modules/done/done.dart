import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewDoneScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Every thing is Done',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }
}
