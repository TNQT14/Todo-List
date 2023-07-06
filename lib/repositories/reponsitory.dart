import 'package:sqflite/sqflite.dart';
import 'package:todolist/repositories/database_connection.dart';
class Reponsitory{
  late DatabaseConnection _databaseConnection;

  Reponsitory(){
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  //Check iif database is exist or not
  Future<Database?> get database async{
    if(_database!=null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  //Insert data into table
  insertData(table, data) async{
    var connection = await database;
    return await connection?.insert(table, data);
  }

}