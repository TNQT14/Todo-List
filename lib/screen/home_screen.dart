import 'package:flutter/material.dart';
import 'package:todolist/helpers/drawer_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoList'),
      ),
      drawer: DrawerNavigation(),
      body: Center(child: Text('Welcome to App'),),
      floatingActionButton: FloatingActionButton(onPressed: () {},
      child: Icon(Icons.add),),
    );
  }
}
