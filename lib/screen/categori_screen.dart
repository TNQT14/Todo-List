import 'package:flutter/material.dart';
import 'package:todolist/screen/home_screen.dart';
import 'package:todolist/screen/home_screen.dart';

class CategoriScreen extends StatefulWidget {
  const CategoriScreen({super.key});

  @override
  State<CategoriScreen> createState() => _CategoriScreenState();
}

class _CategoriScreenState extends State<CategoriScreen> {

  _homeFormDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
    return AlertDialog(
      title: Text('Catelories Form'),
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
