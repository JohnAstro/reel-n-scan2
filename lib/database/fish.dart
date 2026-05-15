import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Fish {
  final String name;
  final String fishInfo;
  final int minSize;
  final int maxSize;
  final int bagLimit;
  final String bait;

  Fish(
      {required this.name,
      required this.fishInfo,
      required this.minSize,
      required this.maxSize,
      required this.bagLimit,
      required this.bait});

  factory Fish.fromSnapshot(DocumentSnapshot snapshot) {
    return Fish(
      name: snapshot['name'],
      fishInfo: snapshot['fishInfo'],
      minSize: snapshot['minSize'],
      maxSize: snapshot['maxSize'],
      bagLimit: snapshot['bagLimit'],
      bait: snapshot['bait'],
    );
  }
}
