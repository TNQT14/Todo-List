import 'package:sqflite/sqflite.dart';
import 'package:todolist/repositories/database_connection.dart';
class Reponsitory{
  late DatabaseConnection _databaseConnection;

  Reponsitory(){
    _databaseConnection = DatabaseConnection();
    print('Call Reponsitory');
  }

  static Database? _database;

  //Check if database is exist or not
  Future<Database?> get database async{
    if(_database!=null) {
      print('Yes database');
      _database = await _databaseConnection.setDatabase();
      return _database;
    }

    print('No dtb');
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  //Insert data into table
  insertData(table, data) async{
    var connection = await database;
    data.remove('id');

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

  readDataByColumnName(table, columnName, columnValue) async{
    var connection = await database;
    return await connection?.query(table, where: '$columnName = ?', whereArgs: [columnValue]);
  }

  updateData(table, data) async   {
    var connection = await database;
    return await connection!.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteData(table, itemId) async {
    print('Called deleteData($table, $itemId)');
    var connection = await database;
    await connection!.rawDelete('DELETE FROM $table WHERE ID = $itemId');

    return await connection.rawUpdate('UPDATE $table SET id = id - 1 WHERE id > $itemId');
  }

}