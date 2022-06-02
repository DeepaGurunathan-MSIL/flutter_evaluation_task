class Otp {
  Response? response;

  Otp({this.response});

  Otp.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class Response {
  String? infoID;
  String? infoMsg;
  String? msgID;

  Response({this.infoID, this.infoMsg, this.msgID});

  Response.fromJson(Map<String, dynamic> json) {
    infoID = json['infoID'];
    infoMsg = json['infoMsg'];
    msgID = json['msgID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['infoID'] = infoID;
    data['infoMsg'] = infoMsg;
    data['msgID'] = msgID;
    return data;
  }
}