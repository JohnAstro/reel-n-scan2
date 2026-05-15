import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reel_n_scan/database/fish.dart';

import '../screens/fish_info_screen.dart';

Widget fishList(BuildContext context, DocumentSnapshot document, TextEditingController _searchController) {
  // reveives each fish and make a button
  final fish = Fish.fromSnapshot(document);

  // ignore: deprecated_member_use
  // button will send the fish information to the fish_info_screen
  return RaisedButton(
      key: Key("search-screen-fish-button"),
      onPressed: () {
        _searchController.clear();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FishInfo(
                      fish: fish,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff4C748B), borderRadius: BorderRadius.circular(5)),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${fish.name}',
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
}
