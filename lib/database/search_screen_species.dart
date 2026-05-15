import 'package:flutter/material.dart';
import 'package:reel_n_scan/database/db_previous_catch_helper.dart';
import 'package:reel_n_scan/database/previousCatch_list.dart';
import 'package:reel_n_scan/database/previousCatch.dart';

class SearchScreenSpecies extends StatefulWidget {
  final bool species;
  final bool location;
  final bool date;
  const SearchScreenSpecies(
      {Key? key,
      required this.species,
      required this.location,
      required this.date})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreenSpecies> {
  final dbService = PreviousLogDataBaseHelper();

  @override
  void dispose() {
    dbService.dispose();
    super.dispose();
  }

  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List of Fishies'),
          backgroundColor: Color(0xff4C748B),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                widget.species
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Species'),
                          onChanged: (value) {
                            keyword = value;
                            setState(() {});
                          },
                        ),
                      )
                    : widget.location
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Location'),
                              onChanged: (value) {
                                keyword = value;
                                setState(() {});
                              },
                            ),
                          )
                        : widget.date
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Date: mm/dd/yyyy'),
                                  onChanged: (value) {
                                    keyword = value;
                                    setState(() {});
                                  },
                                ),
                              )
                            : Text("UH OH!"),
                widget.species
                    ? FutureBuilder<dynamic>(
                        future: dbService.getOnlySpecies(keyword),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return previousCatchList(
                                List<PreviousCatch>.from(snapshot.data));
                          }
                          return const Center(
                            child: Text(
                                'No logs found with this specific Species'),
                          );
                        },
                      )
                    : widget.location
                        ? FutureBuilder<dynamic>(
                            future: dbService.getOnlyLocation(keyword),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return previousCatchList(
                                    List<PreviousCatch>.from(snapshot.data));
                              }
                              return const Center(
                                child: Text(
                                    'No logs found with this specific location'),
                              );
                            },
                          )
                        : widget.date
                            ? FutureBuilder<dynamic>(
                                future: dbService.getOnlyDate(keyword),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return previousCatchList(
                                        List<PreviousCatch>.from(
                                            snapshot.data));
                                  }
                                  return const Center(
                                    child: Text(
                                        'No logs found with this specific date'),
                                  );
                                },
                              )
                            : Text("Uh oh!")
              ],
            ),
          ),
        ));
  }
}
