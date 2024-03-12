class CreateNewNotes {
  bool? status;
  String? msg;
  Records? records;

  CreateNewNotes({this.status, this.msg, this.records});

  CreateNewNotes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    records =
    json['records'] != null ? new Records.fromJson(json['records']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.records != null) {
      data['records'] = this.records!.toJson();
    }
    return data;
  }
}

class Records {
  List<Question>? question;

  Records({this.question});

  Records.fromJson(Map<String, dynamic> json) {
    if (json['question'] != null) {
      question = <Question>[];
      json['question'].forEach((v) {
        question!.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.question != null) {
      data['question'] = this.question!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  int? id;
  String? question;
  int? status;
  String? createdAt;
  String? updatedAt;

  Question(
      {this.id, this.question, this.status, this.createdAt, this.updatedAt});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
////////////////////////////////////////////////////

