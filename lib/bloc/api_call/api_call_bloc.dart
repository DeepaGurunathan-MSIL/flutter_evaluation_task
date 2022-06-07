import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evaluation_task/bloc/api_call/api_call_event.dart';
import 'package:flutter_evaluation_task/bloc/api_call/api_call_state.dart';
import 'package:flutter_evaluation_task/model/login_response.dart';
import 'package:flutter_evaluation_task/model/otp.dart';
import '../../constants/constants.dart';
import '../../model/watchlist.dart';
import '../../service/data_api_call.dart';

class ApiCallBloc extends Bloc<ApiCallEvent,ApiCallState>
{
  ApiCallBloc() : super(ApiCallInitState())
  {
    on<ApiCallEvent>((event, emit) async {
      if(event is FetchWatchlistEvent) {
        await _getWatchlist(emit);
      }else if(event is FetchOTPResponseEvent)
        {
          await _getOTP(emit,event);
        }else if(event is FetchLoginResponseEvent)
      {
        await _getLoginResponse(emit,event);
      } else if (event is CheckGenerateOTPConditionEvent)
        {
          await _getOtpConditionCheck(emit,event);
        } else if (event is CheckLoginOtpEvent)
      {
        await _getLoginOTPValidation(emit,event);
      }
    });
  }

  // Generate OTP Validation

  Future<void> _getOtpConditionCheck(Emitter<ApiCallState> emit,CheckGenerateOTPConditionEvent checkGenerateOTPConditionEvent)
  async {

    if(checkGenerateOTPConditionEvent.phoneNumber.length == 10 && checkGenerateOTPConditionEvent.isChecked)
    {
      emit(GenerateOTPConditionDoneState());
    } else if(checkGenerateOTPConditionEvent.phoneNumber.length<10)
    {
      emit(GenerateOTPMobileErrorState());
    } else if(!checkGenerateOTPConditionEvent.isChecked)
    {
      emit(GenerateOTPCheckboxErrorState());
    }
  }

  // Login OTP Validation

  Future<void> _getLoginOTPValidation(Emitter<ApiCallState> emit,CheckLoginOtpEvent checkLoginOtpEvent)
  async {

    if(checkLoginOtpEvent.otp.length == 4)
    {
      emit(LoginOtpValidationDone());
    }
    else {
      emit(LoginOtpValidationError());
    }
  }

  // OTP

  Future<void> _getOTP(Emitter<ApiCallState> emit,FetchOTPResponseEvent fetchOTPResponseEvent) async {
    emit(OTPLoadingState());
    try {
      final Otp otpData = await  DataApiCall().fetchOTP(fetchOTPResponseEvent.phoneNumber);
      emit(OTPDoneState(otpData: otpData));
    } catch (e) {
      emit (OTPErrorState(
          error: Exception(Constants.networkError)));
    }
  }

  // Login

  Future<void> _getLoginResponse(Emitter<ApiCallState> emit,FetchLoginResponseEvent fetchLoginResponseEvent) async {
    emit(LoginLoadingState());
    try {
      final LoginResponse loginResponse = await  DataApiCall().
      fetchLoginResponse(fetchLoginResponseEvent.otp,fetchLoginResponseEvent.phoneNumber);
      emit(LoginDoneState(loginResponse: loginResponse));
    } catch (e) {
      emit (LoginErrorState(
          error: Exception(Constants.networkError)));
    }
  }

  // Watchlist
  Future<void> _getWatchlist(Emitter<ApiCallState> emit) async {
    emit(WatchlistLoadingState());
    try {
      final WatchList watchlistData = await  DataApiCall().fetchWatchlist();
      emit(WatchlistDoneState(watchlistData: watchlistData));
    } catch (e) {
      emit (WatchlistErrorState(
          error: Exception(Constants.networkError)));
    }
  }
}