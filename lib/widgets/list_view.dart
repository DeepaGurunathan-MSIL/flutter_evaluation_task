import 'package:flutter/material.dart';
import 'package:flutter_evaluation_task/constants/constants.dart';
import 'package:flutter_evaluation_task/model/arguments.dart';
import 'package:flutter_evaluation_task/model/watchlist.dart';
import 'package:intl/intl.dart';

import 'base_navigator.dart';

class Listview extends StatelessWidget {
final List<Symbols> symbols;
  const Listview({
    Key? key,
    required this.symbols,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: symbols.length,
        itemBuilder: (context, index) {
          Symbols sym = symbols[index];
          return _buildWatchlistExpandableTile(context,sym);
        }, separatorBuilder: (BuildContext context, int index) {
          return const Divider();
    },);
  }

  ExpansionTile _buildWatchlistExpandableTile(BuildContext context,Symbols sym) {
    return ExpansionTile(
      collapsedTextColor: Colors.black,
      textColor: Colors.black,
      backgroundColor: Colors.grey.shade300,
      trailing: const SizedBox.shrink(),
        title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                   SizedBox(
                     width: 120,
                     child: Text(sym.dispSym.toString(),
                      style: const TextStyle(
                        fontSize: 17
                      )),
                   ),
                    Text(sym.sym!.exc.toString()
                      ,style: TextStyle(
                      color: Colors.pink.shade100,
                      fontSize: 13,
                    ),),
                   SizedBox(
                     width: 100,
                     child: Text(commaSeparator(sym),
                       textAlign: TextAlign.end,
                       style: const TextStyle(
                       color: Colors.red,
                         fontSize: 17,
                       ),
                     ),
                   )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                   Flexible(
                     child: Text(sym.companyName.toString(),
                        style: const TextStyle(
                            fontSize: 12
                        )),
                   ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(sym.sym!.strike.toString(),
                          style: const TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 15,
                        ),
                        ),
                      ),
                       Text(sym.sym!.tickSize.toString(),
                        style: const TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                      ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 70.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(80,30)),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.0),
              )
              )
              ),
                  onPressed: (){
              BaseNavigator(context,route:Constants.confirmationRoute,arguments: Arguments(symbols: sym)).navigatorPush();
              },
                  child: const Text(Constants.buy)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(80,30)),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.0),
                        )
                    )
                ),
                  onPressed: (){
                    BaseNavigator(context,route:Constants.confirmationRoute,arguments: Arguments(symbols:sym)).navigatorPush();
                  },
                  child: const Text(Constants.sell)),
            )
          ],
        )
      ],
      );
  }

  String commaSeparator(Symbols sym) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('hi');
    numberFormat.format(int.parse(sym.excToken.toString()));
    return numberFormat.format(int.parse(sym.excToken.toString()));
  }
}
