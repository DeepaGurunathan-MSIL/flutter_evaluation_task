
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evaluation_task/bloc/api_call/api_call_bloc.dart';
import 'package:flutter_evaluation_task/bloc/api_call/api_call_state.dart';

import '../bloc/api_call/api_call_event.dart';
import '../constants/constants.dart';
import '../model/watchlist.dart';
import '../widgets/list_view.dart';
import '../widgets/utils.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  WatchlistState createState() => WatchlistState();
}

class WatchlistState extends State<Watchlist> {
  late ApiCallBloc _apiCallBloc;
  List<Symbols>? _symbols;
  @override
  void initState() {
    super.initState();
    _apiCallBloc = BlocProvider.of<ApiCallBloc>(context)
      ..add(FetchWatchlistEvent());
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: Utils().baseAppBar(title: ""),
      body: BlocBuilder <ApiCallBloc,ApiCallState>(
      bloc: _apiCallBloc,
      builder : (BuildContext context , ApiCallState state){
      if(state is WatchlistDoneState){
    _symbols = state.watchlistData.response?.data?.symbols;
     return Padding(
       padding: const EdgeInsets.only(top: 40),
       child: Column(
         children:  [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Center(child: Text(Constants.msilWatchlist,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),)),
            ),
           Expanded(
             child: Listview(
                 symbols: _symbols!),
           )
         ],
       ),
     );}
      if (state is WatchlistErrorState) {
      final error = state.error;
      return Center(child: Text(error.toString()));
      }
      return const Center(child: CircularProgressIndicator());
      })
    );
  }
}
