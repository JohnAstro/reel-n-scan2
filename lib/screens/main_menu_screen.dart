import 'package:flutter/material.dart';
import 'package:reel_n_scan/screens/catch_log_screen.dart';
import 'scan_screen.dart';
import 'search_screen.dart';

class MainMenuScreen extends StatefulWidget {
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool scanButton = false;
  bool searchButton = false;
  bool logButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x000000),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "What reels you in today?",
                    //key: Key("QuestionMenuItem"),
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Orignal Surfer",
                        color: Color(0xffFFFFFF)),
                  )
                ],
              ),

              // scan button padding
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
                            scanButton = !scanButton;
                            searchButton = false;
                            logButton = false;
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Scan()));
                            });
                          },
                          elevation: 0,
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Row(
                              children: [
                                Image.asset('assets/images/scan_icon.png'),
                                Text(
                                  "        Scan          ",
                                  key: Key("scan-button"),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Original Surfer",
                                      color: Color(0xffFFFFFF)),
                                ),
                                Icon(
                                  Icons.check,
                                  color: scanButton
                                      ? Color(0xFF000000)
                                      : Colors.transparent,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // search button padding
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
                          key: Key("searchpressedbutton"),
                          onPressed: () {
                            scanButton = false;
                            searchButton = !searchButton;
                            logButton = false;
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen()));
                            });
                          },
                          elevation: 0,
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Row(
                              children: [
                                Image.asset('assets/images/search_icon.png'),
                                Text(
                                  "             Search       ",
                                  key: Key("search-button"),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Original Surfer",
                                      color: Color(0xffFFFFFF)),
                                ),
                                Icon(
                                  Icons.check,
                                  color: searchButton
                                      ? Color(0xFF000000)
                                      : Colors.transparent,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // log button padding
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
                          key: Key("logpressedbutton"),
                          onPressed: () {
                            scanButton = false;
                            searchButton = false;
                            logButton = !logButton;
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CatchLog()));
                            });
                          },
                          elevation: 0,
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Row(
                              children: [
                                Image.asset('assets/images/log_icon.png'),
                                Text(
                                  "             Log          ",
                                  key: Key("log-button"),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Original Surfer",
                                      color: Color(0xffFFFFFF)),
                                ),
                                Icon(
                                  Icons.check,
                                  color: logButton
                                      ? Color(0xFF000000)
                                      : Colors.transparent,
                                )
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
          ),
        ));
  }
}
