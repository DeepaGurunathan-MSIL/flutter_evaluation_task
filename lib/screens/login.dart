
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evaluation_task/widgets/utils.dart';

import '../bloc/api_call/api_call_bloc.dart';
import '../bloc/api_call/api_call_event.dart';
import '../bloc/api_call/api_call_state.dart';
import '../constants/constants.dart';
import '../model/arguments.dart';
import '../widgets/base_navigator.dart';
import '../widgets/otp_input.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late ApiCallBloc _apiCallBloc;

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  late String _otp;
  late String? _mobileNumber;

  @override
  void initState() {
    super.initState();
    _apiCallBloc = BlocProvider.of<ApiCallBloc>(context);
    _apiEventCall(_apiCallBloc,context);
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Arguments;
    _mobileNumber = args.stringArguments;

    return Scaffold(
      appBar: Utils().baseAppBar(title: Constants.msilWatchlistLogin),
      body:BlocBuilder <ApiCallBloc,ApiCallState>(
          bloc: _apiCallBloc,
          builder : (BuildContext context , ApiCallState state)
          {
         return SingleChildScrollView(
        physics:const NeverScrollableScrollPhysics() ,
        child: Padding(
          padding: const EdgeInsets.only(top: 50,left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(Constants.otpVerification,
              style: TextStyle(
                fontSize: 20
              ),),
               Padding(
                 padding: const EdgeInsets.only(top: 12),
                 child: Text(Constants.otpSubtitle,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
              ),),
               ),
              // Implement 4 input fields
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OtpInput(_fieldOne,call, true),
                      OtpInput(_fieldTwo,call, false),
                      OtpInput(_fieldThree,call, false),
                      OtpInput(_fieldFour,call, false)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap:() {
                  _apiCallBloc.add(FetchOTPResponseEvent(_mobileNumber!));
              },
                child: const Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: Center(
                    child: Text(Constants.resendOtp,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16
                    ),),
                  ),
                ),
              )
            ],
          ),
        ),
      );})
    );
  }

  void call(){
    _otp = _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text;
    if(_otp.length == 4) {
      _apiCallBloc.add(FetchLoginResponseEvent(_otp, _mobileNumber!));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(Utils().snackBar(Constants.enterOtp));
    }
  }

  void _apiEventCall(ApiCallBloc _apiCallBloc,BuildContext context)
  {
    _apiCallBloc.stream.listen((state) {
      if(state is OTPDoneState){
        if(state.otpData.response!.infoID == '0') {
          ScaffoldMessenger.of(context).showSnackBar(
              Utils().snackBar(Constants.otpSent));
        }
        else{
          ScaffoldMessenger.of(context)
              .showSnackBar(Utils().snackBar(Constants.serverError));
        }
      }
      else if(state is OTPErrorState)
      {
        ScaffoldMessenger.of(context).showSnackBar(Utils().snackBar(Constants.networkError));
      }else if(state is LoginDoneState)
      {
        if(state.loginResponse.response!.infoID == '0') {
          ScaffoldMessenger.of(context).showSnackBar(
              Utils().snackBar(Constants.loginSuccess));
          BaseNavigator(context, route: '/WatchList').navigatorPushAndRemoveUntil();
        } else{
          ScaffoldMessenger.of(context)
              .showSnackBar(Utils().snackBar(Constants.serverError));
        }
      }
      else if(state is LoginErrorState){
        ScaffoldMessenger.of(context).showSnackBar(Utils().snackBar(Constants.networkError));
      }
    });
  }

}