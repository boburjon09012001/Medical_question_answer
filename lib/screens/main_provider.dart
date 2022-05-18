import 'package:flutter/material.dart';
import 'package:medical_question_answer/database/database_helper.dart';
import '../models/sick_name.dart';

 class MainProvider extends ChangeNotifier{
    final List<Sick> sicks = [];

    initList({String? sick}) async{
      sicks.clear();
     if(sick == null){
      sicks.addAll(await DatabaseHelper.instance.getSick());
     }
     else{
      sicks.addAll(await DatabaseHelper.instance.getSickLike(sick));
     }
     notifyListeners();
    }
 }