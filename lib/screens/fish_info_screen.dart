import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:reel_n_scan/database/fish.dart';

import 'newlog_screenn.dart';

class FishInfo extends StatefulWidget {
  Fish fish;
  FishInfo({Key? key, required this.fish}) : super(key: key);

  @override
  _FishInfoState createState() => _FishInfoState();
}

class _FishInfoState extends State<FishInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      children: <Widget>[
        AppBar(),
        hero(),
        section(),
      ],
    )));
  }

  Widget AppBar() {
    return Container(
        child: Row(
      children: <Widget>[
        IconButton(
          key: Key("info-screen-back-button"),
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff4C748B),
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(this.context);
          },
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 32.0),
          child: Column(
            children: [
              Text('species',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      fontFamily: "Montserrat",
                      color: Color(0xff4C748B))),
              Text(widget.fish.name,
                  key: Key("info-screen-title"),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: Color(0xff4C748B)))
            ],
          ),
        )),
      ],
    ));
  }

  Widget hero() {
    return Container(
      child: Image.asset('assets/fish_images/${widget.fish.name}.png'),
    );
  }

  Widget section() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Text(
            widget.fish.fishInfo,
            textAlign: TextAlign.justify,
            style:
                TextStyle(color: Color(0xff4C748B), fontSize: 18, height: 1.5),
          ),
          SizedBox(
            height: 20,
          ),
          regulations(),
          SizedBox(height: 15,),
          logButton(),
          SizedBox(height: 15,),
          Text(
            'bait',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Color(0xff4C748B)),
          ),
          property()
        ],
      ),
    );
  }

  Widget property() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Jerkbait',
                style: TextStyle(fontSize: 22, color: Color(0xff4C748B)),
              )
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff4C748B)),
                ),
                onPressed: () => {},
                child: Text('click to buy'),
              )
            ],
          )
        ],
      ),
    );
  }

  regulations() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text('Bag Limit: ' + baglimitreturn(widget.fish.bagLimit),
                  style: TextStyle(fontSize: 20, color: Color(0xff4C748B)))
            ],
          ),
          Row(
            children: [
              Text('Minimum Size: ' + minsizereturn(widget.fish.minSize),
                  style: TextStyle(fontSize: 20, color: Color(0xff4C748B)))
            ],
          ),
          Row(
            children: [
              Text('Maximum Size: ' + maxsizereturn(widget.fish.maxSize),
                  style: TextStyle(fontSize: 20, color: Color(0xff4C748B)))
            ],
          ),
        ],
      ),
    );
  }

  logButton() {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xff4C748B),
          minimumSize: const Size.fromHeight(70),
        ),
        onPressed: () {
          Navigator.push(
              this.context,
              MaterialPageRoute(
                  builder: (context) => HomePage(widget.fish.name)));
        },
        child: const Text(
          "Log Fish",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  minsizereturn(int size) {
    if (size == 0) {
      return 'None';
    } else {
      return size.toString() + '"';
    }
  }
  maxsizereturn(int size) {
    if (size == 0) {
      return 'None';
    } else {
      return size.toString() + '"';
    }
  }
  baglimitreturn(int limit) {
    if (limit == 0) {
      return 'None';
    } else {
      return limit.toString();
    }
  }
}
