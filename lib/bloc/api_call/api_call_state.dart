
import 'package:flutter_evaluation_task/model/login_response.dart';

import '../../model/otp.dart';
import '../../model/watchlist.dart';

class ApiCallState {}

class ApiCallInitState extends ApiCallState {}

// OTP

class OTPLoadingState extends ApiCallState {}

class OTPDoneState extends ApiCallState {
  final Otp otpData;
  OTPDoneState({required this.otpData});
}

class OTPErrorState extends ApiCallState {
  final dynamic error;
  OTPErrorState({required this.error});
}


// Login
class LoginLoadingState extends ApiCallState {}

class LoginDoneState extends ApiCallState {
  final LoginResponse loginResponse;
  LoginDoneState({required this.loginResponse});
}

class LoginErrorState extends ApiCallState {
  final dynamic error;
  LoginErrorState({required this.error});
}

// Watchlist

class WatchlistLoadingState extends ApiCallState {}

class WatchlistDoneState extends ApiCallState {
  final WatchList watchlistData;
  WatchlistDoneState({required this.watchlistData});
}

class WatchlistErrorState extends ApiCallState {
  final dynamic error;
  WatchlistErrorState({required this.error});
}