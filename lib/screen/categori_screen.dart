import 'package:flutter/material.dart';
import 'package:todolist/screen/home_screen.dart';
import 'package:todolist/model/category.dart';
import 'package:todolist/services/categories_service.dart';

class CategoriScreen extends StatefulWidget {
  const CategoriScreen({super.key});

  @override
  State<CategoriScreen> createState() => _CategoriScreenState();

}

class _CategoriScreenState extends State<CategoriScreen> {

  final _categoriesNameController = TextEditingController();
  final _categoriesDescriptionController = TextEditingController();
  final _category = Category();
  final _categoriesService = CategoryService();

  _homeFormDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
    return AlertDialog(
      actions: <Widget>[
        TextButton(

          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
            foregroundColor: MaterialStateProperty.all(
                Colors.white,
            ),
          ),

          onPressed: () {

          },
          child: Text('Cancel'),
        ),
        TextButton(

          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(
              Colors.white,
            ),
          ),
          onPressed: () {
            _category.name = _categoriesNameController.text;
            _category.description = _categoriesDescriptionController.text;
            _categoriesService.saveCategory(_category);
          },
          child: Text('Save'),
        ),
      ],
      title: const Text('Catelories Form'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _categoriesNameController,
              decoration: InputDecoration(
                hintText: 'Write a categories',
                labelText: 'Category',
              ),
            ),
            TextField(
              controller: _categoriesDescriptionController,
              decoration: InputDecoration(
                hintText: 'Write a Description',
                labelText: 'Description',
              ),
              ),
          ],
        ),
      ),
    );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen())),
          color: Colors.white,
        ),
        title: Text('Categories'),
      ),
      body: Center(child: Text('Welcom to Categories')),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _homeFormDialog(context);
      },
      child: Icon(Icons.add),),
    );
  }
}