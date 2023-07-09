import 'package:flutter/gestures.dart';
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
  final _todo = Todo();

  final _todoService = TodoService();

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

  _deleteTodo(BuildContext context, todoId) async{
    print(todoId);
    print('Lay vi id:$todoId');
    todo = await _todoService.readTodoById(todoId);
    print('Lay vi id: ${todo[0]['id']}');
    _deleteFormDialog(context, todoId);
  }

  _showSuccessSnackBar(message){
    // var _snackBar = SnackBar(content: message);
    print('Call _showSuccessSnackBar');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, int index){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: <Widget>[
          //Cancel Button
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              foregroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          //Delete Button
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              foregroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
            ),
            onPressed: () async{
              _todo.id = index;
              // _category.name = _deletecategoriesNameController.text;
              // _category.description = _deletecategoriesDescriptionController.text;
              //
              var result = await _todoService.deleteTodo(_todo.id);
              // // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriScreen()));

              if(result>=0)
              {
                print('Kết quả $result');
                print('Call Navigator.pop(context)');
                getAllTodo();
                print('Navigator.pop(context) success');
                Navigator.pop(context);
                _showSuccessSnackBar('Delete succesful');
                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CategoriScreen()));
                // print('Navigator.of(context) success');
                // getAllCategories();
              }
            },
            child: Text('Delete'),
          ),
        ],
        title: const Text('Are you sure you want to delete this'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
  _todoList.sort((a, b) => a.todoDate!.compareTo(b!.todoDate!));
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoList'),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(itemCount: _todoList.length, itemBuilder: (context, index){
        final todo = _todoList[index];

        final longPressGestureRecognizer = LongPressGestureRecognizer()
          ..onLongPress = () {
            _deleteTodo(context, _todoList[index].id);
          };

      return Padding(
        padding: EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPress: longPressGestureRecognizer.onLongPress,
          child: Card(
            elevation: 4.0,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${_todoList[index].title?.toString() ?? 'Ảo thật đấy'}'),
                ],
              ),
              subtitle: Text(_todoList[index].category ?? 'No category'),
              trailing: Text(_todoList[index].todoDate ?? 'Do Date'),
            ),
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
