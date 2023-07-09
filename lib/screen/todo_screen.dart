import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todolist/services/categories_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController =TextEditingController();
  var todoDescriptionController = TextEditingController();
  var todoDateController = TextEditingController();


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


    // _categories.forEach((category){
    //   setState(() {
    //     String categoryName = category['name'].toString();
    //     _categories.add((DropdownMenuItem<String>(
    //       child: Text(categoryName),
    //       value: categoryName,
    //     ))).toList();
    //   });
    // });

    setState(() {
      _categories = categories.map<DropdownMenuItem<String>>((category) {
        String categoryName = category['name'].toString();
        return DropdownMenuItem<String>(
          child: Text(categoryName),
          value: categoryName,
        );
      }).toList().cast<DropdownMenuItem<String>>();
    });

    print(_categories);
  }

  @override
  Widget build(BuildContext context) {

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
            controller: todoDateController,
            decoration: InputDecoration(
              labelText: 'Date',
              hintText: 'Pick a Date',
              prefixIcon: InkWell(
                onTap: (){},
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
              onPressed: (){},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Màu nền khi nút không được nhấn
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Màu chữ khi nút không được nhấn
                overlayColor: MaterialStateProperty.all<Color>(Colors.blueAccent), // Màu nền khi nút được nhấn
              ),
              child: Text('Save', style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
