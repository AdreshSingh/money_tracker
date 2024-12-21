import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_tracker/google_sheet_api.dart';
import 'package:money_tracker/loading_circle.dart';
import 'package:money_tracker/plus_button.dart';
import 'package:money_tracker/topcard.dart';
import 'package:money_tracker/transactions.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // collect user input
  final _textControllerAmount = TextEditingController();
  final _textControllerItem = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  //? to add the new transaction
  void enterTransaction() {
    GoogleSheetApi.insert(
      _textControllerItem.text,
      _textControllerAmount.text,
      _isIncome,
    );

    setState(() {});
  }

  //? new transaction
  void _newTransaction() {
    showDialog(
      context: context,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, setState) {
        return AlertDialog(
          title: Text("NEW TRANSACTION"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // for income / expense
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Expense"),
                    Switch(
                        value: _isIncome,
                        onChanged: (value) {
                          setState(() {
                            _isIncome = value;
                            // print(_isIncome);
                          });
                        }),
                    Text("Income"),
                  ],
                ),

                SizedBox(
                  height: 5,
                ),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _textControllerAmount,
                    decoration: InputDecoration(
                      hintText: "Amount?",
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),

                SizedBox(
                  height: 5,
                ),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _textControllerItem,
                    decoration: InputDecoration(
                      hintText: "For what?",
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.grey[600],
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                enterTransaction();
                Navigator.of(context).pop();
                // }
              },
              color: Colors.grey[600],
              child: Text(
                "Enter",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  //? wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timerMain) {
      if (GoogleSheetApi.loading == false) {
        setState(() {});
        timerMain.cancel();

        // Timer.periodic(Durations.medium4, (timerSecondary) {
        //   setState(() {});
        //   timerMain.cancel();
        //   timerSecondary.cancel();
        // });
        // print(GoogleSheetApi.cureentTransaction);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start the laoding till the data arrives
    if (GoogleSheetApi.loading == true && timerHasStarted == false) {
      startLoading();
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // Text("Total Balance Card"),
            TopNeucard(
              balance:
                  '${GoogleSheetApi.calculateIncome() - GoogleSheetApi.calculateExpense()}',
              income: '${GoogleSheetApi.calculateIncome()}',
              expense: '${GoogleSheetApi.calculateExpense()}',
            ),

            Expanded(
              child: SizedBox(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GoogleSheetApi.loading == true
                            ? LoadingCircle()
                            : ListView.builder(
                                itemCount:
                                    GoogleSheetApi.cureentTransactions.length,
                                itemBuilder: (context, index) {
                                  return Transactions(
                                    transactionName: GoogleSheetApi
                                        .cureentTransactions[index][0],
                                    money: GoogleSheetApi
                                        .cureentTransactions[index][1],
                                    incomeOrExpense: GoogleSheetApi
                                        .cureentTransactions[index][2],
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            PlusButton(
              function: _newTransaction,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
