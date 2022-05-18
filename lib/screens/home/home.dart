import 'package:flutter/material.dart';
import 'package:medical_question_answer/main.dart';
import 'package:medical_question_answer/screens/home/widgets/sick_list.dart';
import 'package:provider/provider.dart';

import '../main_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  bool _isDark = false;
  String searchQuery = "Search query";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : Container(),
        title: _isSearching ? _buildSearchField() : const Text("Information"),
        actions: _buildActions(),
      ),
      body:const SickList(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration:const InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style:const TextStyle(color: Colors.white, fontSize: 21.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController ==  null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),

      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
      IconButton(onPressed: (){
        setState(() {
          _isDark = !_isDark;
          ThemaStream.setThema.add(_isDark);

        });
      },
          icon: _isDark
              ? const Icon(Icons.wb_sunny)
              : const Icon(Icons.nights_stay_outlined)),



    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
      updateQuery(sick: searchQuery);
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  void updateQuery({String? sick}){
    final mainProvider =Provider.of<MainProvider>(context, listen: false);
    mainProvider.initList(sick: sick);
  }
}
