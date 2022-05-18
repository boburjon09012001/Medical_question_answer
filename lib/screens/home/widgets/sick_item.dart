import 'package:flutter/material.dart';
import '../../../models/sick_name.dart';
import '../../details/details_page.dart';

class SickItem extends StatelessWidget {
  final Sick sick;
  const SickItem(this.sick,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder:
              (context)=> DetailsPage(sick)));
        },
        child: Card(
          elevation: 4,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            height: 100,
            child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                child:
                Row(
                    children: [
                      Flexible(
                        child:  Text(sick.question ?? "...",
                          maxLines: 25,
                          softWrap: true,
                          style:const TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 0.5
                          ),overflow: TextOverflow.fade,
                        ),
                      ),
                      const  SizedBox(width: 20,),
                      const Icon(Icons.chevron_right_sharp,
                        size: 25,
                        color: Colors.black38,
                      ),
                    ]
                )

            ),
          ),
        ),
      ),
    );
  }
}
