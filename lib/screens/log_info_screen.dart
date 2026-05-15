import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:reel_n_scan/database/previousCatch.dart';

class LogInfo extends StatefulWidget {
  PreviousCatch fish;
  LogInfo({Key? key, required this.fish}) : super(key: key);

  @override
  _LogInfoState createState() => _LogInfoState();
}

class _LogInfoState extends State<LogInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: <Widget>[
        AppBar(),
        section(),
      ],
    )));
  }

  Widget AppBar() {
    return Container(
        child: Row(
      children: <Widget>[
        IconButton(
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
              Text('You made it!',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      fontFamily: "Montserrat",
                      color: Color(0xff4C748B))),
              // Text(widget.fish.name,
              //     style: TextStyle(
              //         fontWeight: FontWeight.w700,
              //         fontSize: 26,
              //         color: Color(0xff4C748B)))
            ],
          ),
        )),
      ],
    ));
  }

  Widget section() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Text(
            widget.fish.Species,
            textAlign: TextAlign.justify,
            style:
                TextStyle(color: Color(0xff4C748B), fontSize: 18, height: 1.5),
          ),
          SizedBox(
            height: 20,
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
                'Bait',
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
}
