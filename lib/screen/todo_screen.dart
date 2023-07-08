import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _selectValue;
  var _categories;

  @override
  Widget build(BuildContext context) {
    var todoTitleController =TextEditingController();
    var todoDescriptionController = TextEditingController();
    var todoDateController = TextEditingController();

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
          DropdownButtonFormField(
            value: _selectValue,
            items: _categories,
            hint: Text('Category'),
            onChanged: (value){
              setState(() {
                _selectValue = value;
              });
            },
          ),
          SizedBox(
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
