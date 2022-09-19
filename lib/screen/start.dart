// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/helpers/dropDown.dart';
import 'package:quizapp/helpers/style.dart';
import 'package:quizapp/model/answer.dart';
import 'package:quizapp/screen/question.dart';
import 'package:quizapp/service/apiService.dart';

class StartPage extends StatefulWidget {
  StartPage();
  @override
  _StartPageState createState() => new _StartPageState();
}

class _StartPageState extends State<StartPage> {
  DropListModel difficultyList = DropListModel([
    OptionItem(id: "1", title: "Easy"),
    OptionItem(id: "2", title: "Medium"),
    OptionItem(id: "3", title: "Hard"),
  ]);
  OptionItem chooseDifficulty = OptionItem(id: "", title: "Choose difficulty");

  DropListModel categoryList = DropListModel([
    OptionItem(id: "1", title: "CMS"),
    OptionItem(id: "2", title: "Linux"),
    OptionItem(id: "3", title: "Docker"),
    OptionItem(id: "4", title: "DevOps"),
    OptionItem(id: "5", title: "Code"),
    OptionItem(id: "6", title: "SQL"),
  ]);
  OptionItem chooseCategory = OptionItem(id: "", title: "Choose category");
  String difficulty = "";
  String category = "";
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
          content: Text(category == ""
              ? "Choose category"
              : difficulty == ""
                  ? "Choose difficulty"
                  : "")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldMessengerKey,
        appBar: AppBar(
          title: Text("Quiz App"),
          leading: SizedBox(),
        ),
        body: Builder(
          builder: (contextz) => Column(
            children: [
              Container(
                  margin: EdgeInsets.all(16),
                  child: SelectDropList(
                    chooseDifficulty,
                    difficultyList,
                    (optionItem) {
                      chooseDifficulty = optionItem;
                      setState(() {
                        difficulty = optionItem.title;
                      });
                    },
                  )),
              Container(
                  margin: EdgeInsets.all(16),
                  child: SelectDropList(
                    chooseCategory,
                    categoryList,
                    (optionItem) {
                      chooseCategory = optionItem;
                      setState(() {
                        category = optionItem.title;
                      });
                    },
                  )),
              Container(
                margin: EdgeInsets.all(8),
                child: Divider(),
              ),
              GestureDetector(
                  onTap: () async {
                    if (difficulty == "" || category == "") {
                      _showToast(contextz);
                    } else {
                      await ApiServices.getQuestions(difficulty, category)
                          .then((value) {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (builder) => QuestionPage(
                                      questions: value,
                                      category: category,
                                      difficulty: difficulty,
                                    )));
                      }).catchError((onError) {
                        /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: SnackBar(content: Text(onError.toString()))));*/
                      });
                    }
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: buttonUI("Start"))),
            ],
          ),
        ));
  }
}
