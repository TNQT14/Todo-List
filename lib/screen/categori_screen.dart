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
  List<Category> _cateloryList = <Category>[];

  getAllCategories() async{
    _cateloryList = <Category>[];
    var categories = await _categoriesService.readCategories();

    categories.forEach((category){
      setState(() {
        var categoryModel = Category();
        categoryModel.id = category['id'];
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        _cateloryList.add(categoryModel);
      });
    });
  }

  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  _homeFormDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
    return AlertDialog(
      actions: <Widget>[
        //Cancel Button
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
        //Save Button
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(
              Colors.white,
            ),
          ),
          onPressed: () async{
            _category.name = _categoriesNameController.text;
            _category.description = _categoriesDescriptionController.text;

            var result = await _categoriesService.saveCategory(_category);
            print(result);
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriScreen()));
          },
          child: Text('Save'),
        ),
      ],
      title: const Text('Categories Form'),
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
          onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen())),
          color: Colors.white,
        ),
        title: Text('Categories'),
      ),
      body: ListView.builder(itemCount: _cateloryList.length, itemBuilder: (context, index){
        return Padding(
          padding: EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0),
          child: Card(
            elevation: 4.0,
            child: ListTile(
              leading: IconButton(icon: Icon(Icons.edit), onPressed: (){
                //Process edit button late
              },),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_cateloryList[index]?.name ?? 'null'),
                  IconButton(onPressed: (){
                    //Process delete button late
                  },
                    icon: Icon(Icons.delete), color: Colors.red,)
                ],
              ),
              subtitle: Text(_cateloryList[index]?.description ?? 'null'),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _homeFormDialog(context);
      },
      child: Icon(Icons.add),),
    );
  }
}