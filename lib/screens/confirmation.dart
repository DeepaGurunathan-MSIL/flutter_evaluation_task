import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evaluation_task/bloc/update_status/update_status_bloc.dart';
import 'package:flutter_evaluation_task/bloc/update_status/update_status_event.dart';
import 'package:flutter_evaluation_task/constants/constants.dart';
import '../bloc/update_status/update_status_state.dart';
import '../model/arguments.dart';
import '../widgets/base_navigator.dart';
import '../widgets/utils.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  ConfirmationState createState() => ConfirmationState();
}

class ConfirmationState extends State<Confirmation> {
  late UpdateStatusBloc _statusBloc;
  bool _statusCheck = false;

  @override
  void initState() {
    super.initState();
    _statusBloc = BlocProvider.of<UpdateStatusBloc>(context)
      ..add(UpdateStatusConfirmEvent());
  }
  @override
  Widget build(BuildContext context)
  {
    final args = ModalRoute.of(context)!.settings.arguments as Arguments;

    return Scaffold(
      appBar: Utils().baseAppBar(title: ""),
      body:BlocBuilder <UpdateStatusBloc,UpdateStatusState>(
      bloc: _statusBloc,
     builder : (BuildContext context , UpdateStatusState state){
        if(state is UpdateStatusCompletedState){
          _statusCheck = state.status;
      return _statusCheck ?
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30,right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:  [
                GestureDetector(
                  child: const Text(Constants.logout,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15
                  ),),
                  onTap: ()=>{
                  BaseNavigator(context,route:Constants.generateOtpRoute).navigatorPushAndRemoveUntil()
                  },
                ),
              ],
            ),
          ),
           const Flexible(
             flex: 5,
             child: Center(
               child: Text(Constants.successful,
               style: TextStyle(
                 color: Colors.red,
                 fontWeight: FontWeight.bold,
                 fontSize: 40
               ),),
             ),
           ),
        ],
      ) :
      Padding(
        padding: const EdgeInsets.only(top: 30,left: 30,right: 20),
        child: Center(
          child: Column(
            children: [
              const Text(Constants.msilWatchlist,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold
              ),),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children:[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        Flexible(
                          flex: 5,
                          child: Column(
                            children: [
                              _buildNames(Constants.name),
                              _buildNames(Constants.details),
                              _buildNames(Constants.ltp),
                              _buildNames(Constants.change),
                              _buildNames(Constants.changePercent),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Column(
                            children: [
                              _buildValues(args.symbols!.dispSym.toString()),
                              _buildValues(args.symbols!.companyName.toString()),
                              _buildValues(args.symbols!.excToken.toString()),
                              _buildValues(args.symbols!.sym!.tickSize.toString()),
                              _buildValues(args.symbols!.sym!.strike.toString()),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(onPressed: (){
                  _statusBloc = BlocProvider.of<UpdateStatusBloc>(context)
                    ..add(UpdateStatusCompleteEvent());
                },
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(const Size(200,40)),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.0),
                            )
                        )
                    ),
                    child: const Text(Constants.submit)),
              )
            ],
          ),
        ),
      );}
        return Container();
      }
      )
    );
  }

  Padding _buildValues(String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(value,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 16
        ),),
    );
  }

  Padding _buildNames(String name) {
    return Padding(
      padding: const EdgeInsets.only(top:25.0),
      child: Text(name,
        style: const TextStyle(
            fontSize: 16
        ),),
    );
  }
}
