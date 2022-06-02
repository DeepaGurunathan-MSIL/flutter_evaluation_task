import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evaluation_task/bloc/api_call/api_call_bloc.dart';
import 'package:flutter_evaluation_task/bloc/update_status/update_status_bloc.dart';
import 'package:flutter_evaluation_task/screens/confirmation.dart';
import 'package:flutter_evaluation_task/screens/login.dart';
import 'package:flutter_evaluation_task/screens/generate_otp.dart';
import 'package:flutter_evaluation_task/screens/watch_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Named Route Navigation',
      routes: {
        '/GenerateOTP': (context) =>  BlocProvider<ApiCallBloc>(
          create: (BuildContext context) => ApiCallBloc(),
          child: const GenerateOTP(),
        ),
        '/Login': (context) =>  BlocProvider<ApiCallBloc>(
          create: (BuildContext context) => ApiCallBloc(),
          child: const Login(),
        ),
        '/WatchList': (context) =>  BlocProvider<ApiCallBloc>(
          create: (BuildContext context) => ApiCallBloc(),
          child: const Watchlist(),
        ),
        '/Confirmation': (context) =>  BlocProvider<UpdateStatusBloc>(
    create: (BuildContext context) => UpdateStatusBloc(),
    child: const Confirmation(),
    ),
      },
      home: BlocProvider<ApiCallBloc>(
        create: (BuildContext context) => ApiCallBloc(),
    child: const GenerateOTP())
    );
  }
}
