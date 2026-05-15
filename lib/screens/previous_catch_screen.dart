import 'package:flutter/material.dart';
import 'newlog_screenn.dart';
import 'package:reel_n_scan/database/db_previous_catch_helper.dart';
import 'package:reel_n_scan/database/previousCatch.dart';
import 'package:reel_n_scan/database/previousCatch_list.dart';
import 'package:reel_n_scan/database/search_screen_species.dart';

// this allows for the creation of the screen (related to button input in main_menu_screen)
class PreviousCatchLog extends StatefulWidget {
  @override
  Previous_Catch_Log createState() => Previous_Catch_Log();
}

// this creates the interface of the stuff
class Previous_Catch_Log extends State<PreviousCatchLog> {
  final dbService = PreviousLogDataBaseHelper();

  @override
  void dispose() {
    dbService.dispose();
    super.dispose();
  }

  bool newcatchButton = false;
  bool previouscatchButton = false;

  bool speciesButton = false;
  bool locationButton = false;
  bool dateButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF000000),
        // app bar adds the top bar with the back button!
        appBar: AppBar(
          title: Text("Previous Catch Log"),
          backgroundColor: Color(0xff4C748B),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Species padding!
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Container(
                width: 337,
                height: 96,
                decoration: BoxDecoration(
                  color: Color(0xff4C748B),
                  border: Border.all(
                    width: 3,
                    style: BorderStyle.solid,
                    color: Color(0xff4C748B),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 47,
                      child: RaisedButton(
                        key: Key("scanpressedbutton"),
                        onPressed: () {
                          newcatchButton = !newcatchButton;
                          previouscatchButton = false;
                          setState(() {
                            speciesButton = true;
                            locationButton = false;
                            dateButton = false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreenSpecies(
                                          species: speciesButton,
                                          location: locationButton,
                                          date: dateButton,
                                        )));
                          });
                        },
                        elevation: 0,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Row(
                            children: [
                              Text(
                                "         Species          ",
                                key: Key("scan notification"),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Original Surfer",
                                    color: Color(0xffFFFFFF)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Location padding!
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Container(
                width: 337,
                height: 96,
                decoration: BoxDecoration(
                  color: Color(0xff4C748B),
                  border: Border.all(
                    width: 3,
                    style: BorderStyle.solid,
                    color: Color(0xff4C748B),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 47,
                      child: RaisedButton(
                        key: Key("scanpressedbutton"),
                        onPressed: () {
                          newcatchButton = !newcatchButton;
                          previouscatchButton = false;
                          setState(() {
                            speciesButton = false;
                            locationButton = true;
                            dateButton = false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreenSpecies(
                                          species: speciesButton,
                                          location: locationButton,
                                          date: dateButton,
                                        )));
                          });
                        },
                        elevation: 0,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Row(
                            children: [
                              Text(
                                "         Location          ",
                                key: Key("Scan Notification"),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Original Surfer",
                                    color: Color(0xffFFFFFF)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Date padding!
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Container(
                width: 337,
                height: 96,
                decoration: BoxDecoration(
                  color: Color(0xff4C748B),
                  border: Border.all(
                    width: 3,
                    style: BorderStyle.solid,
                    color: Color(0xff4C748B),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 47,
                      child: RaisedButton(
                        key: Key("scanpressedbutton"),
                        onPressed: () {
                          newcatchButton = !newcatchButton;
                          previouscatchButton = false;
                          setState(() {
                            speciesButton = false;
                            locationButton = false;
                            dateButton = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreenSpecies(
                                          species: speciesButton,
                                          location: locationButton,
                                          date: dateButton,
                                        )));
                          });
                        },
                        elevation: 0,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Row(
                            children: [
                              Text(
                                "         Date          ",
                                key: Key("Scan Notification"),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Original Surfer",
                                    color: Color(0xffFFFFFF)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
