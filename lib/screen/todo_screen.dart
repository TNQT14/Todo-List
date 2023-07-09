// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todolist/services/categories_service.dart';
import 'package:intl/intl.dart';
import 'package:todolist/services/todo_service.dart';
import 'package:todolist/model/todo.dart';

import 'home_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController =TextEditingController();
  var todoDescriptionController = TextEditingController();
  var _todoDateController = TextEditingController();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();


  @override
  void initState(){
    super.initState();
    _loadCategories();
}

  var _selectValue;
  List<DropdownMenuItem<String>> _categories = [];

  _loadCategories() async {
    var _categoriesService = CategoryService();
    var categories = await _categoriesService.readCategories();

    setState(() {
      _categories = categories.map<DropdownMenuItem<String>>((category) {
        String categoryName = category['name'].toString();
        return DropdownMenuItem<String>(
          child: Text(categoryName),
          value: categoryName,
        );
      }).toList().cast<DropdownMenuItem<String>>();
    });
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

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async{
    var _pickDate = await showDatePicker(context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if(_pickDate !=null)
      {
        setState(() {
          _dateTime=_pickDate;
          _todoDateController.text = DateFormat('dd-MM-yyyy').format(_pickDate);
        });
      }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen())),
          color: Colors.white,
        ),
        title: const Text('To do screen'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: todoTitleController,
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Write Todo Title',
            ),
          ),
          TextField(
            controller: todoDescriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Write Todo Description',
            ),
          ),
          TextField(
            controller: _todoDateController,
            decoration: InputDecoration(
              labelText: 'Date',
              hintText: 'Pick a Date',
              prefixIcon: InkWell(
                onTap: (){
                  _selectedTodoDate(context);
                },
                child: Icon(Icons.calendar_today),
              )
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
            value: _selectValue,
            items: _categories,
            hint: Text('Category'),
            onChanged: (value){
              print('DropdownButtonFormField');
              setState(() {
                _selectValue = value;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                var todoObject = Todo();

                todoObject.title = todoTitleController.text;
                todoObject.description = todoDescriptionController.text;
                todoObject.category = _selectValue.toString();
                todoObject.isFinished=0;
                todoObject.todoDate = _todoDateController.text;

                var _todoService = TodoService();
                var result = await _todoService.saveTodo(todoObject);

                if(result>0)
                  _showSuccessSnackBar('Created');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Màu nền khi nút không được nhấn
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Màu chữ khi nút không được nhấn
                overlayColor: MaterialStateProperty.all<Color>(Colors.blueAccent), // Màu nền khi nút được nhấn
              ),
              child: Text('Save', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}

