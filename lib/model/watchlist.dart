class WatchList {
  Response? response;

  WatchList({this.response});

  WatchList.fromJson(Map<String, dynamic> json) {
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
  String? appID;
  Data? data;

  Response({this.appID, this.data});

  Response.fromJson(Map<String, dynamic> json) {
    appID = json['appID'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appID'] = appID;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Symbols>? symbols;

  Data({this.symbols});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['symbols'] != null) {
      symbols = <Symbols>[];
      json['symbols'].forEach((v) {
        symbols!.add(Symbols.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (symbols != null) {
      data['symbols'] = symbols!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Symbols {
  String? baseSym;
  String? companyName;
  String? dispSym;
  String? excToken;
  String? haircut;
  String? isin;
  String? mCap;
  String? sector;
  Sym? sym;
  bool? ttEligibility;

  Symbols(
      {this.baseSym,
        this.companyName,
        this.dispSym,
        this.excToken,
        this.haircut,
        this.isin,
        this.mCap,
        this.sector,
        this.sym,
        this.ttEligibility});

  Symbols.fromJson(Map<String, dynamic> json) {
    baseSym = json['baseSym'];
    companyName = json['companyName'];
    dispSym = json['dispSym'];
    excToken = json['excToken'];
    haircut = json['haircut'];
    isin = json['isin'];
    mCap = json['mCap'];
    sector = json['sector'];
    sym = json['sym'] != null ? Sym.fromJson(json['sym']) : null;
    ttEligibility = json['tt_eligibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['baseSym'] = baseSym;
    data['companyName'] = companyName;
    data['dispSym'] = dispSym;
    data['excToken'] = excToken;
    data['haircut'] = haircut;
    data['isin'] = isin;
    data['mCap'] = mCap;
    data['sector'] = sector;
    if (sym != null) {
      data['sym'] = sym!.toJson();
    }
    data['tt_eligibility'] = ttEligibility;
    return data;
  }
}

class Sym {
  String? asset;
  String? exc;
  String? expiry;
  String? id;
  String? instrument;
  String? lotSize;
  String? multiplier;
  String? optionType;
  String? streamSym;
  String? strike;
  String? tickSize;

  Sym(
      {this.asset,
        this.exc,
        this.expiry,
        this.id,
        this.instrument,
        this.lotSize,
        this.multiplier,
        this.optionType,
        this.streamSym,
        this.strike,
        this.tickSize});

  Sym.fromJson(Map<String, dynamic> json) {
    asset = json['asset'];
    exc = json['exc'];
    expiry = json['expiry'];
    id = json['id'];
    instrument = json['instrument'];
    lotSize = json['lotSize'];
    multiplier = json['multiplier'];
    optionType = json['optionType'];
    streamSym = json['streamSym'];
    strike = json['strike'];
    tickSize = json['tickSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asset'] = asset;
    data['exc'] = exc;
    data['expiry'] = expiry;
    data['id'] = id;
    data['instrument'] = instrument;
    data['lotSize'] = lotSize;
    data['multiplier'] = multiplier;
    data['optionType'] = optionType;
    data['streamSym'] = streamSym;
    data['strike'] = strike;
    data['tickSize'] = tickSize;
    return data;
  }
}
