import 'package:flutter/material.dart';
import 'package:todolist/helpers/drawer_navigation.dart';
import 'package:todolist/screen/todo_screen.dart';
import 'package:todolist/services/todo_service.dart';
import 'package:todolist/model/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> _todoList = <Todo>[];
  var todo;

  @override
  initState(){
    super.initState();
    getAllTodo();
  }

  getAllTodo() async{
    TodoService _todoService = TodoService();
    _todoList = <Todo>[];
    var todos = await _todoService.readTodo();

    setState(() {
    });

    todos.forEach((todo){
      setState(() {
        var todoModel = Todo();
        todoModel.id = todo['id'];
        todoModel.title = todo['title'];
        todoModel.description = todo['description'];
        todoModel.todoDate = todo['todoDate'];
        todoModel.category = todo['category'];
        todoModel.isFinished = todo['isFinished'];
        _todoList.add(todoModel);
        // print('categoryModel.id = ${categoryModel.id}');
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoList'),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(itemCount: _todoList.length, itemBuilder: (context, index){
      return Padding(
        padding: EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0),
        child: Card(
          elevation: 4.0,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${_todoList[index].id ?? 'null'}.${_todoList[index].title?.toString() ?? 'Ảo thật đấy'}'),
              ],
            ),
            subtitle: Text(_todoList[index].category ?? 'No category'),
            trailing: Text(_todoList[index].todoDate ?? 'Do Date'),
          ),
        ),
      );
    }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TodoScreen()));
      },
        child: Icon(Icons.add),),
    );
  }
}
