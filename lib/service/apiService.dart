import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quizapp/model/questionModel.dart';
import 'package:requests/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiServices {
  static const String apiKey = "j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa";

  static Future<List<Question>> getQuestions(
      String difficulty, String category) async {
    var parameters = {
      'apiKey': apiKey,
      'limit': '10',
      'category': category,
      'difficulty': difficulty,
    };
    final request = await Requests.get(
      'https://quizapi.io/api/v1/questions',
      queryParameters: parameters,
      headers: {'Accept': '*/*', 'Content-type': 'text/plain; charset=utf-8'},
    );
    if (request.statusCode == 200) {
      var io = json
          .encode(request.json())
          .replaceAll('{', '{')
          .replaceAll(': ', '": "')
          .replaceAll(', ', '", "')
          .replaceAll('}', '}');
      return questiontFromJson(request.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future saveResults(String category, DateTime dateTime,
      String difficulty, int corrects) async {
    await FirebaseFirestore.instance.collection("results").doc().set({
      'category': category,
      'dateTime': dateTime,
      'difficulty': difficulty,
      'correct_answers': corrects
    });
  }
}
