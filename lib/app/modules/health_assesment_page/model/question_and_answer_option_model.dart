class QuestionAndAnswerOptionModel {
  bool? status;
  String? msg;
  List<Results>? results;

  QuestionAndAnswerOptionModel({this.status, this.msg, this.results});

  QuestionAndAnswerOptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  Question? question;
  List<Answers>? answers;

  Results({this.question, this.answers});

  Results.fromJson(Map<String, dynamic> json) {
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  int? id;
  int? categoryId;
  String? question;
  String? createdAt;
  String? updatedAt;

  Question(
      {this.id,
        this.categoryId,
        this.question,
        this.createdAt,
        this.updatedAt});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    question = json['question'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['question'] = this.question;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Answers {
  int? id;
  int? questionId;
  String? answer;
  String? createdAt;
  String? updatedAt;

  Answers(
      {this.id, this.questionId, this.answer, this.createdAt, this.updatedAt});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    answer = json['answer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_id'] = this.questionId;
    data['answer'] = this.answer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
