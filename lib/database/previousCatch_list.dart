// ignore_for_file: type_init_formals, deprecated_member_use

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:reel_n_scan/database/db_previous_catch_helper.dart';
import 'package:reel_n_scan/database/previousCatch.dart';
import 'package:reel_n_scan/screens/log_info_screen.dart';

class previousCatchList extends StatelessWidget {
  List<PreviousCatch> fishes;

  previousCatchList(List<PreviousCatch> this.fishes, {Key? key})
      : super(key: key);
  final dbService = PreviousLogDataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // listView is just meant so I can see how fishes is being stored
        ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8),
            itemCount: fishes.length, // fishes.length
            itemBuilder: (BuildContext context, int index) {
              return RaisedButton(
                  // key doesn't necessarily mess with what we are trying to do
                  // as of right now at least
                  key: Key('${fishes[index].id}'),
                  onPressed: () {
                    print("You pressed the button");
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => FishInfo(
                    //               fish: fishes[index],
                    //             )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff4C748B),
                          borderRadius: BorderRadius.circular(5)),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              //${fishes[index].Location} ${fishes[index].Time}
                              '${fishes[index].id}, ${fishes[index].Species}, ${fishes[index].Location}, ${fishes[index].Date}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            }),
      ],
    ));
  }
}
