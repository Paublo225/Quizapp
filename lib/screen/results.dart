// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/helpers/dropDown.dart';
import 'package:quizapp/helpers/style.dart';
import 'package:quizapp/model/answer.dart';
import 'package:quizapp/model/questionModel.dart';
import 'package:quizapp/screen/start.dart';
import 'package:quizapp/service/apiService.dart';

class ResultPage extends StatefulWidget {
  int corrects;
  DateTime dateTime;
  String category;
  String difficulty;
  ResultPage(
      {Key? key,
      required this.corrects,
      required this.category,
      required this.dateTime,
      required this.difficulty})
      : super(key: key);
  @override
  ResultPageState createState() => ResultPageState();
}

class ResultPageState extends State<ResultPage> {
  String dateTime = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime =
        "${widget.dateTime.day}/${widget.dateTime.month}/${widget.dateTime.year} ${widget.dateTime.hour}:${widget.dateTime.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Results',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.only(left: 8, right: 8, top: 150),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                margin: EdgeInsets.all(8),
                child: Text("Quiz completed at: $dateTime")),
            Container(child: Text("Category: ${widget.category}")),
            Container(
                margin: EdgeInsets.all(8),
                child: Text("Difficulty: ${widget.difficulty}")),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(8),
                child: Text("Quiz results:${widget.corrects}/10")),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: buttonUI("Save", onTap: () async {
                  await ApiServices.saveResults(widget.category,
                          widget.dateTime, widget.difficulty, widget.corrects)
                      .then((value) => Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (builder) => StartPage())));
                }))
          ])),
    );
  }
}
