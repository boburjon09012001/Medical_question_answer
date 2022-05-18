import 'package:flutter/material.dart';
import 'package:medical_question_answer/screens/home/widgets/sick_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../database/database_helper.dart';
import '../../../utils/constants.dart';
import '../../main_provider.dart';

class SickList extends StatefulWidget {
  const SickList({Key? key}) : super(key: key);

  @override
  State<SickList> createState() => _SickListState();
}

class _SickListState extends State<SickList> {
  @override
  void initState() {
    super.initState();
    loadDB();
  }


  Future<void> loadDB() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
   bool isloaded = prefs.getBool(Constants.IS_DATABASE_INIT) ?? false;
   if(!isloaded){
    await  DatabaseHelper.instance.loadDB(context);

   }
  }


  @override
  Widget build(BuildContext context) {
    updateQuery();
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Scrollbar(
          isAlwaysShown: true,
          thickness: 6,
          hoverThickness: 12,
          child: Consumer<MainProvider>(builder: (context, data, child) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 10),
                    itemBuilder: (context, index) {
                      return SickItem(data.sicks[index]);},
                    itemCount: data.sicks.length * 1,
                  );
            }),
        ),
    );
  }
  void updateQuery({String? sick}){
    final mainProvider =Provider.of<MainProvider>(context, listen: false);
    mainProvider.initList(sick: sick);
  }
}
