import 'package:todolist/model/todo.dart';
import 'package:todolist/repositories/reponsitory.dart';

class TodoService{
  late Reponsitory _reponsitory;

  TodoService(){
    _reponsitory=Reponsitory();
  }

  saveTodo(Todo todo) async {
    return await _reponsitory.insertData('todo', todo.todoMap());
  }

}