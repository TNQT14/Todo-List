import 'package:todolist/services/todo_service.dart';

class Todo{
  int? id;
  String? title;
  String? description;
  String? category;
  String? todoDate;
  int? isFinished;

  todoMap(){
    var mapping = Map<String, dynamic>();
    mapping['id']=id;
    mapping['title']=title;
    mapping['description']=description;
    mapping['todoDate']=todoDate;
    mapping['category']=category;
    mapping['isFinished']=isFinished;
    return mapping;
  }
}