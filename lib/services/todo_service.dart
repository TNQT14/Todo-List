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

  readTodo() async{
    return await _reponsitory.readData('todo');
  }

  readTodoById(todoId) async{
    return await _reponsitory.readDataById('todo',todoId);
  }

  deleteTodo(todoId) async{
    return await _reponsitory.deleteData('todo',todoId);
  }
}