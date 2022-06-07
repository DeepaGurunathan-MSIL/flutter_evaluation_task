import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evaluation_task/bloc/api_call/api_call_event.dart';
import 'package:flutter_evaluation_task/widgets/utils.dart';

import '../bloc/api_call/api_call_bloc.dart';
import '../bloc/api_call/api_call_state.dart';
import '../constants/constants.dart';
import '../model/arguments.dart';
import '../widgets/base_navigator.dart';

class GenerateOTP extends StatefulWidget {
  const GenerateOTP({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GenerateOTPState();
}

class _GenerateOTPState extends State<GenerateOTP> {
  late ApiCallBloc _apiCallBloc;
  bool isChecked = false;
  final TextEditingController _mobileNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _apiCallBloc = BlocProvider.of<ApiCallBloc>(context);
    _apiEventCall(_apiCallBloc, context);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Utils().baseAppBar(title: Constants.msilWatchlistLogin),
      body:BlocBuilder <ApiCallBloc,ApiCallState>(
      bloc: _apiCallBloc,
    builder : (BuildContext context , ApiCallState state){
        if(state is OTPLoadingState){
          return const Center(child: CircularProgressIndicator());
        }
     return SingleChildScrollView(
        // physics:const NeverScrollableScrollPhysics() ,
        child: Padding(
          padding: const EdgeInsets.only(top: 50,
              left: 10,right: 10,bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:   <Widget>[
                const Text(Constants.loginMobileNoTitle,
                style: TextStyle(color: Colors.black,
                fontSize: 27,)
                ),
               Padding(
                 padding: const EdgeInsets.only(top: 30),
                 child: Text(Constants.loginMobileNoSubTitle,
                    style: TextStyle(color: Colors.grey.shade400,
                      fontSize: 17,)
              ),
               ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(Constants.phoneNUmber,
                    style: TextStyle(color: Colors.black,
                      fontSize: 17,)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: 30,
                      width: 40,
                      decoration: Utils().shapeDecoration(color:Colors.grey.shade300),
                      child: const Center(child: Text(Constants.nineOne)),
                  ),
                ),
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TextField(
                            controller: _mobileNoController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0
                                )
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: GestureDetector(
                  onTap: ()=>{setState(() => isChecked = !isChecked)},
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                              value: isChecked,
                              onChanged: (value){
                                setState(() => isChecked = !isChecked);
                              }
                          ),
                        ),
                        // You can play with the width to adjust your
                        // desired spacing
                        const Text(Constants.termsAndConditions,style:
                          TextStyle(
                            color: Colors.black,
                            fontSize: 15
                          ),)
                      ]
                  ),
                ),
              ),
              Center(
               child:
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(500,40)),
                      backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.0),
                          )
                      )
                  ),
                    onPressed:() {
                    _apiCallBloc.add(CheckGenerateOTPConditionEvent(_mobileNoController.text.toString(),isChecked));
                    }, child: const Text(Constants.generateOtp,
                style: TextStyle(
                  fontSize: 20
                ),))
              ),
            ],
          ),
        ),
      );
    })
    );
  }

  void _apiEventCall(ApiCallBloc _apiCallBloc,BuildContext context)
  {
    _apiCallBloc.stream.listen((state) {
      if(state is OTPDoneState){
        if(state.otpData.response!.infoID == '0') {
          ScaffoldMessenger.of(context)
              .showSnackBar(Utils().snackBar(Constants.otpSent));
          BaseNavigator(context,
              route: Constants.loginRoute,
              arguments: Arguments(
                  stringArguments: Constants.nineOne +
                      _mobileNoController.text.toString()))
              .navigatorPush();
        } else{
          ScaffoldMessenger.of(context)
              .showSnackBar(Utils().snackBar(Constants.serverError));
        }
      }
      else if(state is OTPErrorState)
      {
        ScaffoldMessenger.of(context).showSnackBar(Utils().snackBar(Constants.networkError));
      }
      else if(state is GenerateOTPConditionDoneState){
        _apiCallBloc.add(FetchOTPResponseEvent(Constants.nineOne+_mobileNoController.text.toString()));
      }else if(state is GenerateOTPMobileErrorState){
        ScaffoldMessenger.of(context).showSnackBar(Utils().snackBar(Constants.incorrectMobileNumber));
      }else if(state is GenerateOTPCheckboxErrorState){
        ScaffoldMessenger.of(context).showSnackBar(Utils().snackBar(Constants.termsErrorMessage));
      }
    });
  }

}