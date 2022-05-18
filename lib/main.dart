import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medical_question_answer/screens/home/home.dart';
import 'package:medical_question_answer/screens/main_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => MainProvider(),
      )
    ], child:const  MyApp()),
  );
}
class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ThemaStream.setThema.stream,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          return
            MaterialApp(
            debugShowCheckedModeBanner: false,
             darkTheme: ThemeData.dark(),
             themeMode:snapshot.data ? ThemeMode.dark  : ThemeMode.light,
            theme: ThemeData(
              primaryColor: Colors.white,
              // fontFamily: "Poppins",
            ),
            home: const HomePage(),
          );
    });
  }
}

class ThemaStream{
  static StreamController<bool> setThema = StreamController();

}