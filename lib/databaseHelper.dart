import 'dart:io';
import 'package:flutter_application_1/data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper{
DataBaseHelper._privateConstructor();
static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
static Database? _database;
Future<Database> get database async=> _database ??= await _initDatabase();
Future <Database> _initDatabase() async{
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, 'details.db'); 
return await openDatabase(path,
version: 1,
onCreate: _onCreate,
);
}
Future _onCreate (Database db, int version) async{
await db.execute('''
CREATE TABLE details(
  id INTEGER PRIMARY KEY,
  latitude TEXT,
  longitude TEXT,
  type TEXT,
  price TEXT
)
''');
}
Future <List<Detail>> getDetails() async{
Database db = await instance.database;
var details= await db.query('details', orderBy: 'id');
List<Detail> detailList = details.isNotEmpty? details.map((c) =>Detail.fromMap(c)).toList(): [];
return detailList;
} 
Future <int>  add(Detail detail) async{
Database db = await instance.database;
return await db.insert('details', detail.toMap());
}
Future <int> remove(int id )async{
Database db = await instance.database;
return await db.delete('details', where: 'id=?', whereArgs: [id]);
}
Future <int> update (Detail detail) async{
   Database db = await instance.database;
   return await db.update('details', detail.toMap(), where: 'id=?', whereArgs: [detail.id]);
}
}