class ApiCallEvent {}

class FetchOTPResponseEvent extends ApiCallEvent {
  late String phoneNumber;
  FetchOTPResponseEvent(this.phoneNumber);
}

class FetchLoginResponseEvent extends ApiCallEvent {
  late String otp;
  late String phoneNumber;
  FetchLoginResponseEvent(this.otp,this.phoneNumber);
}

class FetchWatchlistEvent extends ApiCallEvent {}
