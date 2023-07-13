import 'package:flutter/material.dart';
import 'package:todolist/model/category.dart';
import 'package:todolist/screen/categori_screen.dart';
import 'package:todolist/screen/home_screen.dart';
import 'package:todolist/screen/todo_by_category.dart';
import 'package:todolist/services/categories_service.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {

  List<Widget> _cateloryList = <Widget>[];
  CategoryService _categoryService = CategoryService();

  getAllCategories() async{
    var categories = await _categoryService.readCategories();

    categories.forEach((category){
      setState(() {
        _cateloryList.add(InkWell(
          onTap: ()=>Navigator.push(context, MaterialPageRoute(
              builder: (context) => new TodoByCategory(category['name'],))),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('https://scr.vn/wp-content/uploads/2020/07/avt-%C4%91%E1%BA%B9p-cho-nam.jpg'),
                ),
                accountName: Text('Quang Thái'),
                accountEmail: Text('2002quangthai@gmail.com'),
                decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.view_list),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoriScreen())),
            ),
            Divider(),
            Column(
              children: _cateloryList,
            )
          ],
        ),
      ),
    );
  }
}
