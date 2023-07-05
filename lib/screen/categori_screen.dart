import 'package:flutter/material.dart';

class CategoriScreen extends StatefulWidget {
  const CategoriScreen({super.key});

  @override
  State<CategoriScreen> createState() => _CategoriScreenState();
}

class _CategoriScreenState extends State<CategoriScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Center(child: Text('Welcom to Categories')),
      floatingActionButton: FloatingActionButton(onPressed: (){},
      child: Icon(Icons.add),),
    );
  }
}
