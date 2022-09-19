// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/helpers/dropDown.dart';
import 'package:quizapp/helpers/style.dart';
import 'package:quizapp/model/answer.dart';
import 'package:quizapp/model/questionModel.dart';
import 'package:quizapp/screen/results.dart';
import 'package:quizapp/screen/start.dart';
import 'package:quizapp/service/apiService.dart';

class QuestionPage extends StatefulWidget {
  List<Question> questions;

  String category;
  String difficulty;
  QuestionPage(
      {Key? key,
      required this.questions,
      required this.category,
      required this.difficulty})
      : super(key: key);
  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {
  int _questionIndex = 0;

  bool endOfQuiz = false;
  bool correctAnswerSelected = false;
  List<Answer> answersList = [];
  List<String> correctAnswers = [];
  int corrects = 0;
  getAnswers() {
    widget.questions[_questionIndex].correctAnswers
        .toJson()
        .forEach((key, value) {
      correctAnswers.add(value);
    });
    widget.questions[_questionIndex].answers.toJson().forEach((key, value) {
      if (value != "") {
        answersList.add(Answer(
          answerText: value,
          answerTap: _nextQuestion,
        ));
      }
    });
  }

  void _nextQuestion() {
    //Перед следующим воросом обновляем списки ответов
    correctAnswers.clear();
    answersList.clear();
    //После последнего вопроса переходим на страницу результата
    if (_questionIndex + 1 >= widget.questions.length) {
      endOfQuiz = true;
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (builder) => ResultPage(
                    category: widget.category,
                    dateTime: DateTime.now(),
                    difficulty: widget.difficulty,
                    corrects: corrects,
                  )));
    }
    //Обновление индекса вопроса и получание его вариантов ответов
    setState(() {
      if (_questionIndex + 1 < widget.questions.length) _questionIndex++;
      getAnswers();
    });
  }

  @override
  void initState() {
    super.initState();
    getAnswers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Question ${_questionIndex + 1}/10',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180.0,
              margin: EdgeInsets.only(
                  bottom: 10.0, left: 30.0, right: 30.0, top: 30),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(blurRadius: 20, offset: Offset(0, 10))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  widget.questions[_questionIndex].question,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Column(
              children: [
                for (int i = 0; i < answersList.length; i++)
                  Answer(
                    answerText: answersList[i].answerText,
                    answerTap: (() {
                      if (correctAnswers[i] == "true") {
                        setState(() {
                          corrects += 1;
                        });
                      }

                      _nextQuestion();
                    }),
                    answerCorrect: correctAnswers[i],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
