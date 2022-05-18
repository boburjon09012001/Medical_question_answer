import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medical_question_answer/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../models/sick_name.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _db;

  DatabaseHelper._instance();

  final String tableName = "medical";
  final String colId = 'id';
  final String colQuestion = 'question';
  final String colAnswer = 'answer';

  Future<Database?> get db async {
    return _db ?? await _initDB();
  }

  Future<Database?> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "medical.db";
    _db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
         await db.execute("CREATE TABLE $tableName ("
              "$colId INTEGER PRIMARY KEY,"
              "$colQuestion TEXT,"
              "$colAnswer TEXT"


         //
              ")");
        });
    return _db;
  }
  Future<void> loadDB(context)async{
    String data =
    await DefaultAssetBundle.of(context).loadString("assets/medicalinfo.json");
    final jsonResult =  jsonDecode(data);
    List<Sick> answer = jsonResult
       .map<Sick>((data){
         return Sick.fromJson(data);
    }).toList();

   for(var sick in answer){
    await insert(sick);
   }
    saveState();
  }

  Future<void>  saveState() async{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.IS_DATABASE_INIT, true);
  }

  Future<Sick> insert(Sick sick) async {
    final data = await db;
    sick.id = await data?.insert(tableName, sick.toMap());
    return sick;
  }

  Future<List<Map<String, Object?>>?> getSickMap({String? sick}) async {
    final data = await db;
    final List<Map<String, Object?>>? result;
    if(sick == null){
    result = await data?.query(tableName);
    }
    else{
      result = await data?.query(tableName,
      where: "question LIKE ?",
        whereArgs: ["%$sick%"],
      );
    }
    return result;
  }

  Future<List<Sick>> getSick() async {
    final List<Map<String, Object?>>? sickMap = await getSickMap();
    final List<Sick> sicks = [];
    sickMap?.forEach((element) {
      sicks.add(Sick.fromMap(element));
    });
    return sicks;
  }

  Future<int?> update(Sick sick) async {
    final data = await db;
    return await data?.update(tableName, sick.toMap(),
        where: '$colId = ?', whereArgs: [sick.id]);
  }
  Future<int?> delete(int sickID) async{
    final data = await db;
    return await data?.delete(
        tableName, where: "$colId = ?", whereArgs: [sickID]);

  }

  Future<List<Sick>> getSickLike(String sick) async{
    final List<Map<String, Object?>>? sickMap = await getSickMap(sick: sick);
    final List<Sick> sicks = [];
    sickMap?.forEach((element) {
      sicks.add(Sick.fromMap(element));
    });
    return sicks;
  }
}
