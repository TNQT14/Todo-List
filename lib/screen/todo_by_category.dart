import 'package:flutter/material.dart';
import 'package:todolist/services/todo_service.dart';

import '../model/todo.dart';

class TodoByCategory extends StatefulWidget {

  late String? category;
  TodoByCategory(this.category);

  @override
  State<TodoByCategory> createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  List<Todo> _todoList = <Todo>[];
  TodoService _todoService = TodoService();

  @override
  void initState(){
    super.initState();
    getTodoByCategory();
  }

  getTodoByCategory() async{
    var todos = await _todoService.readTodoByCategory(this.widget.category);
    todos.forEach((todo){
      setState(() {
        var model = Todo();
        model.title = todo['title'];
        model.category = todo['category'];
        model.description = todo['description'];
        model.todoDate = todo['todoDate'];
        model.category = todo['category'];
        model.isFinished = todo['isFinished'];

        _todoList.add(model);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(this.widget.category!),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: ListView.builder(itemCount: _todoList.length,itemBuilder: (context, index){
            return Card(
              elevation: 4.0,
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${_todoList[index].title?.toString() ?? 'Ảo thật đấy'}'),
                  ],
                ),
                subtitle: Text(_todoList[index].category ?? 'No category'),
                trailing: Text(_todoList[index].todoDate ?? 'No Date'),
              ),
            );
          }))
        ],
      ),
    );
  }
}
