import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reel_n_scan/database/db_service.dart';
import 'package:reel_n_scan/database/fish_list.dart';
import 'package:reel_n_scan/database/fish.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // text editing for search bar
  TextEditingController _searchController = TextEditingController();
  //store the data from the firestore database
  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  // listener
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  // disposes the search query if search bar empty
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getFishes();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var fishSnapshot in _allResults) {
        var title = Fish.fromSnapshot(fishSnapshot).name.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(fishSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  // statement to query the firestore database
  getFishes() async {
    var fishes = await FirebaseFirestore.instance
        .collection('fishes')
        .orderBy('name')
        .get();
    setState(() {
      _allResults = fishes.docs;
    });
    searchResultsList();
    return "Complete";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           leading: BackButton(
          key: Key("search-screen-back-button"),
   ), 
          title: Text('List of Species'),
          backgroundColor: Color(0xff4C748B),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                key: Key("search-screen-search-bar"),
                controller: _searchController,
                decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
              ),
              Expanded(
                  child: ListView.builder(
                    key: Key("search-screen-list"),
                itemCount: _resultsList.length,
                itemBuilder: (BuildContext context, int index) =>
                    fishList(context, _resultsList[index], _searchController),
              ))
            ],
          ),
        ));
  }
}
