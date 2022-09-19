// ignore_for_file: file_names
import 'dart:convert';

List<Question> questiontFromJson(String str) =>
    List<Question>.from(json.decode(str).map((dynamic x) {
      return Question.fromJson(x);
    }));

class Question {
  late int id;
  late String question;
  late String description;
  late Answers answers;
  String? multipleCorrectAnswers;
  late CorrectAnswers correctAnswers;
  late String explanation;
  String? tip;
  List<String>? tags;
  late String category;
  late String difficulty;
  Question(
      {required this.id,
      required this.question,
      required this.description,
      required this.answers,
      this.multipleCorrectAnswers,
      required this.correctAnswers,
      required this.explanation,
      this.tip,
      this.tags,
      required this.category,
      required this.difficulty});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    description = json['description'] ?? "";
    answers =
        (json['answers'] != null ? Answers.fromJson(json['answers']) : null)!;
    multipleCorrectAnswers = json['multiple_correct_answers'];
    correctAnswers = (json['correct_answers'] != null
        ? CorrectAnswers.fromJson(json['correct_answers'])
        : null)!;
    explanation = json['explanation'] ?? "";
    tip = json['tip'];

    category = json['category'];
    difficulty = json['difficulty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['description'] = description;
    if (answers != null) {
      data['answers'] = answers.toJson();
    }
    data['multiple_correct_answers'] = multipleCorrectAnswers;
    if (correctAnswers != null) {
      data['correct_answers'] = correctAnswers.toJson();
    }
    data['explanation'] = explanation;
    data['tip'] = tip;

    data['category'] = category;
    data['difficulty'] = difficulty;
    return data;
  }
}

class Answers {
  late String answerA;
  late String answerB;
  late String answerC;
  late String answerD;

  Answers({
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
  });

  Answers.fromJson(Map<String, dynamic> json) {
    answerA = json['answer_a'];
    answerB = json['answer_b'];
    answerC = json['answer_c'] ?? "";
    answerD = json['answer_d'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer_a'] = answerA;
    data['answer_b'] = answerB;
    data['answer_c'] = answerC;
    data['answer_d'] = answerD;

    return data;
  }
}

class CorrectAnswers {
  late String answerACorrect;
  late String answerBCorrect;
  late String answerCCorrect;
  late String answerDCorrect;

  CorrectAnswers({
    required this.answerACorrect,
    required this.answerBCorrect,
    required this.answerCCorrect,
    required this.answerDCorrect,
  });

  CorrectAnswers.fromJson(Map<String, dynamic> json) {
    answerACorrect = json['answer_a_correct'];
    answerBCorrect = json['answer_b_correct'];
    answerCCorrect = json['answer_c_correct'];
    answerDCorrect = json['answer_d_correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer_a_correct'] = answerACorrect;
    data['answer_b_correct'] = answerBCorrect;
    data['answer_c_correct'] = answerCCorrect;
    data['answer_d_correct'] = answerDCorrect;

    return data;
  }
}
