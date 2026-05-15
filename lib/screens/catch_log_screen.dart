import 'package:flutter/material.dart';
import 'newlog_screenn.dart';
import 'previous_catch_screen.dart';

// stl (creates new class)

// this allows for the creation of the screen (related to button input in main_menu_screen)
class CatchLog extends StatefulWidget {
  @override
  Catch_Log createState() => Catch_Log();
}

// this creates the interface of the stuff
class Catch_Log extends State<CatchLog> {
  bool newcatchButton = false;
  bool previouscatchButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x000000),
        // app bar adds the top bar with the back button!
        appBar: AppBar(
          title: Text("Catch Log"),
          backgroundColor: Color(0xff4C748B),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // New Catch padding!
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage("")));
                              });
                            },
                            elevation: 0,
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "              New Catch          ",
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

                // Previous Catch padding!
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
                              newcatchButton = false;
                              previouscatchButton = !previouscatchButton;
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PreviousCatchLog())); // next page
                              });
                            },
                            elevation: 0,
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "         Previous Catch          ",
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
                )
              ]),
        ));
  }
}
