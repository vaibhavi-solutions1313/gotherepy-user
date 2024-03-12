///New Notes List Class
class NewNotesList {
  bool? status;
  String? msg;
  List<Records>? records;

  NewNotesList({this.status, this.msg, this.records});

  NewNotesList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  String? date;
  Journal? journal;

  Records({this.date, this.journal});

  Records.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    journal =
    json['journal'] != null ? new Journal.fromJson(json['journal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.journal != null) {
      data['journal'] = this.journal!.toJson();
    }
    return data;
  }
}

class Journal {
  int? id;
  int? userId;
  int? journalId;
  String? answer;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? question;

  Journal(
      {this.id,
        this.userId,
        this.journalId,
        this.answer,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.question});

  Journal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    journalId = json['journal_id'];
    answer = json['answer'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['journal_id'] = this.journalId;
    data['answer'] = this.answer;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['question'] = this.question;
    return data;
  }
}