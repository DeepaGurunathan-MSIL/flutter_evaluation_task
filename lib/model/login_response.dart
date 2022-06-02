class LoginResponse {
  Response? response;

  LoginResponse({this.response});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  Data? data;
  String? msgID;

  Response({this.infoID, this.data, this.msgID});

  Response.fromJson(Map<String, dynamic> json) {
    infoID = json['infoID'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msgID = json['msgID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['infoID'] = infoID;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msgID'] = msgID;
    return data;
  }
}

class Data {
  String? jSESSIONID;
  String? loginCount;
  String? url;

  Data({this.jSESSIONID, this.loginCount, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    jSESSIONID = json['JSESSIONID'];
    loginCount = json['loginCount'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['JSESSIONID'] = jSESSIONID;
    data['loginCount'] = loginCount;
    data['url'] = url;
    return data;
  }
}
