import 'package:flutter/material.dart';
import '../../models/sick_name.dart';

class DetailsPage extends StatelessWidget {
  final Sick sick;
  const DetailsPage(this.sick,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
      children: [
        SafeArea(
        child: Container(
          padding:const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: detailsWidget(context),
        ),
      ),
      ],
      ),
    );
  }
  Widget detailsWidget(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:  Icon(Icons.arrow_back, size: 29.0,),),
        const SizedBox(height: 30.0),
        const Text("Question",
          style: TextStyle(fontSize: 22.0,
              fontWeight: FontWeight.w700
          ),
        ),
        const SizedBox(height: 20.0),

        Text(sick.question ?? "...",
          style:const TextStyle(   fontSize: 20.0,
              letterSpacing: 0.5),
        ),
        const SizedBox(height: 20.0,),
        const Text("Answer",
          style: TextStyle(fontSize: 22.0,
              fontWeight: FontWeight.w700
          ),
        ),
        const SizedBox(height: 20.0),
        Text(sick.answer ?? "...",
          style:const TextStyle(
              fontSize: 20.0,
              letterSpacing: 0.5
          ),
        ),

        const SizedBox(height: 30.0),
      ],
    );
  }
}
