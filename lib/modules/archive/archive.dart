import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewArchiveScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Archive',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }
}
