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

class CheckGenerateOTPConditionEvent extends ApiCallEvent {
  late String phoneNumber;
  late bool isChecked;
  CheckGenerateOTPConditionEvent(this.phoneNumber,this.isChecked);
}

class CheckLoginOtpEvent extends ApiCallEvent {
  late String otp;
  CheckLoginOtpEvent(this.otp);
}
