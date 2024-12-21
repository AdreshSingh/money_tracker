import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  final String transactionName;
  final String money;
  final String incomeOrExpense;

  const Transactions({
    super.key,
    required this.transactionName,
    required this.money,
    required this.incomeOrExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 50,
          color: Colors.grey[200],
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        "\$",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      transactionName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${incomeOrExpense == 'expense' ? '-' : '+'} \$$money",
                  style: TextStyle(
                    color: (incomeOrExpense == 'expense'
                        ? Colors.red
                        : Colors.green),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
