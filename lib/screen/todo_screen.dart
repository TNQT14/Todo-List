import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    var todoTitleController;

    return Scaffold(
      appBar: AppBar(
        title: Text('To do screen'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: todoTitleController,
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Write todo title',
            ),
          )
        ],
      ),
    );
  }
}
