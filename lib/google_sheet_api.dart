import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gsheets/gsheets.dart';
import 'package:money_tracker/secret.dart';

class GoogleSheetApi {
  // varibales for worksheet
  static late Worksheet? _worksheet;

  // variables to keep with backend
  static int numberOfTransaction = 0;
  static List<List<dynamic>> cureentTransactions = [];
  static bool loading = true;

  // initalize the spreadsheet
  Future<void> init() async {
    // loading secret file
    await dotenv.load(fileName: '.env');

    //! working in web & desktop but not in mobile
    // Load credentials JSON from file
    // final credentialsPath = dotenv.env['CREDENTIALS_PATH'] ?? '';
    // final credentialsFile = File(credentialsPath);

    // final creditionals = credentialsFile.readAsStringSync();
    // debugPrint(creditionals);

    //? old unsafe method used
    final creditionals = Secret.creditional;

    final String spreadsheetId = dotenv.env['SPREADSHEET_ID'] ?? "";

    // init Gsheets
    final gsheets = GSheets(creditionals);

    // fetching a spreadsheet by id
    final workbook = await gsheets.spreadsheet(spreadsheetId);

    // fetching a spreading by it's name
    final Worksheet? spreadSheet = workbook.worksheetByTitle('workbook1');

    // setting to new spreadsheet to global one
    _worksheet = spreadSheet;

    countRows(spreadSheet);
  }

// count the number of notes
  static Future<void> countRows(Worksheet? worksheet) async {
    while ((await worksheet!.values
            .value(column: 1, row: numberOfTransaction + 1)) !=
        '') {
      numberOfTransaction++;
    }
    // now we know how many notes to load, now let's load them
    loadTransaction(worksheet);
  }

  static Future loadTransaction(Worksheet? worksheet) async {
    if (worksheet == null) return;

    for (int i = 1; i < numberOfTransaction; i++) {
      final String transactionName =
          await worksheet.values.value(column: 1, row: i + 1);

      final String transactionAmount =
          await worksheet.values.value(column: 2, row: i + 1);

      final String transactionType =
          await worksheet.values.value(column: 3, row: i + 1);

      if (cureentTransactions.length < numberOfTransaction) {
        cureentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }

      if (kDebugMode) {
        print(cureentTransactions);
      }
      // stops the loader
      loading = false;
    }
  }

  static Future insert(String name, String amount, bool isIncome) async {
    if (_worksheet == null) return;

    numberOfTransaction++;

    cureentTransactions.add([
      name,
      amount,
      isIncome == true ? 'income' : 'expense',
    ]);

    await _worksheet!.values.appendRow([
      name,
      amount,
      isIncome == true ? 'income' : 'expense',
    ]);
  }

  //? calculate the total income
  static double calculateIncome() {
    double totalIncome = 0;
    for (var currentTransaction in cureentTransactions) {
      if (currentTransaction[2] == 'income') {
        totalIncome += double.parse(currentTransaction[1]);
      }
    }
    return totalIncome;
  }

  //? calculate the total expense
  static double calculateExpense() {
    double totalIncome = 0;
    for (var currentTransaction in cureentTransactions) {
      if (currentTransaction[2] == 'expense') {
        totalIncome += double.parse(currentTransaction[1]);
      }
    }
    return totalIncome;
  }
}
