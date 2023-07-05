import 'package:flutter/material.dart';
import 'package:todolist/screen/categori_screen.dart';
import 'package:todolist/screen/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
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
            )
          ],
        ),
      ),
    );
  }
}
