class Therapists {
  bool? status;
  String? msg;
  List<Results>? results;

  Therapists({this.status, this.msg, this.results});

  Therapists.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add( Results.fromJson(v));
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
  int? profileId;
  String? email;
  String? phone;
  String? username;
  int? doctorType;
  String? createdAt;
  String? updatedAt;
  int? doctorId;
  String? name;
  String? degree;
  String? title;
  int? exp;
  int? rate;
  String? idProof;
  String? about;
  String? gender;
  String? avatar;
  String? educationProof;
  String? doctorTypeName;
  int? isOnlineChat;
  int? isOnlineSession;
  String? tags;
  String? description;
  dynamic counsellingId;
  dynamic icon;
  List<String>? specialization;
  MultipleSessionPrices? multipleSessionPrices;

  Results(
      {this.profileId,
        this.email,
        this.phone,
        this.username,
        this.doctorType,
        this.createdAt,
        this.updatedAt,
        this.doctorId,
        this.name,
        this.degree,
        this.title,
        this.exp,
        this.rate,
        this.idProof,
        this.about,
        this.gender,
        this.avatar,
        this.educationProof,
        this.doctorTypeName,
        this.isOnlineChat,
        this.isOnlineSession,
        this.tags,
        this.description,
        this.counsellingId,
        this.icon,
        this.specialization,
        this.multipleSessionPrices});

  Results.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    doctorType = json['doctor_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctorId = json['doctor_id'];
    name = json['name'];
    degree = json['degree'];
    title = json['title'];
    exp = json['exp'];
    rate = json['rate'];
    idProof = json['id_proof'];
    about = json['about'];
    gender = json['gender'];
    avatar = json['avatar'];
    educationProof = json['education_proof'];
    doctorTypeName = json['doctor_type_name'];
    isOnlineChat = json['is_online_chat'];
    isOnlineSession = json['is_online_session'];
    tags = json['tags'];
    description = json['description'];
    counsellingId = json['counselling_id'];
    icon = json['icon'];
    specialization = json['specialization'].cast<String>();
    multipleSessionPrices = json['multiple_session_prices'] is Map
        ?  MultipleSessionPrices.fromJson(json['multiple_session_prices'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['profile_id'] = this.profileId;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['username'] = this.username;
    data['doctor_type'] = this.doctorType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['doctor_id'] = this.doctorId;
    data['name'] = this.name;
    data['degree'] = this.degree;
    data['title'] = this.title;
    data['exp'] = this.exp;
    data['rate'] = this.rate;
    data['id_proof'] = this.idProof;
    data['about'] = this.about;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['education_proof'] = this.educationProof;
    data['doctor_type_name'] = this.doctorTypeName;
    data['is_online_chat'] = this.isOnlineChat;
    data['is_online_session'] = this.isOnlineSession;
    data['tags'] = this.tags;
    data['description'] = this.description;
    data['counselling_id'] = this.counsellingId;
    data['icon'] = this.icon;
    data['specialization'] = this.specialization;
    if (this.multipleSessionPrices != null) {
      data['multiple_session_prices'] = this.multipleSessionPrices!.toJson();
    }
    return data;
  }
}

class MultipleSessionPrices {
  List<CallSession>? callSession;
  List<ChatSession>? chatSession;

  MultipleSessionPrices({this.callSession, this.chatSession});

  MultipleSessionPrices.fromJson(Map<String, dynamic> json) {
    if (json['call_session'] != null) {
      callSession = <CallSession>[];
      json['call_session'].forEach((v) {
        callSession!.add(CallSession.fromJson(v));
      });
    }
    if (json['chat_session'] != null) {
      chatSession = <ChatSession>[];
      json['chat_session'].forEach((v) {
        chatSession!.add(ChatSession.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.callSession != null) {
      data['call_session'] = this.callSession!.map((v) => v.toJson()).toList();
    }
    if (this.chatSession != null) {
      data['chat_session'] = this.chatSession!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CallSession {
  int? sessionPrice;
  int? sessionCount;
  String? discountInPercent;
  dynamic priceAfterAllExcludedTaxes;
  String? durationInMinutes;

  CallSession(
      {this.sessionPrice,
        this.sessionCount,
        this.discountInPercent,
        this.priceAfterAllExcludedTaxes,
        this.durationInMinutes});

  CallSession.fromJson(Map<String, dynamic> json) {
    sessionPrice = json['session_price'];
    sessionCount = json['session_count'];
    discountInPercent = json['discountInPercent'];
    priceAfterAllExcludedTaxes = json['price_after_all_excluded_taxes'];
    durationInMinutes = json['durationInMinutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_price'] = this.sessionPrice;
    data['session_count'] = this.sessionCount;
    data['discountInPercent'] = this.discountInPercent;
    data['price_after_all_excluded_taxes'] = this.priceAfterAllExcludedTaxes;
    data['durationInMinutes'] = this.durationInMinutes;
    return data;
  }
}

class ChatSession {
  int? chatSessionPrice;
  int? chatSessionCount;
  String? discountInPercent;
  num? priceAfterAllExcludedTaxes;
  String? durationInMinutes;

  ChatSession(
      {this.chatSessionPrice,
        this.chatSessionCount,
        this.discountInPercent,
        this.priceAfterAllExcludedTaxes,
        this.durationInMinutes});

  ChatSession.fromJson(Map<String, dynamic> json) {
    chatSessionPrice = json['chat_session_price'];
    chatSessionCount = json['chat_session_count'];
    discountInPercent = json['discountInPercent'];
    priceAfterAllExcludedTaxes = json['price_after_all_excluded_taxes'];
    durationInMinutes = json['durationInMinutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_session_price'] = this.chatSessionPrice;
    data['chat_session_count'] = this.chatSessionCount;
    data['discountInPercent'] = this.discountInPercent;
    data['price_after_all_excluded_taxes'] = this.priceAfterAllExcludedTaxes;
    data['durationInMinutes'] = this.durationInMinutes;
    return data;
  }
}



