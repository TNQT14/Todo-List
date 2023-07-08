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
    return await connection!.insert(table, data);
  }

  //Read data into table
  readData(table) async{
    var connection = await database;
    return await connection!.query(table);
  }

  readDataById(String table, itemId) async{
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  updateData(table, data) async   {
    var connection = await database;
    return await connection!.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

}