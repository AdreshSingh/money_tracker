import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gsheets/gsheets.dart';

void main() async {
  // loading secret file
  await dotenv.load();

  // loading secret data
  String creditionals = dotenv.env['API_KEY'] ?? "";

  final String spreadsheetId = dotenv.env['SPREADSHEET_ID'] ?? "";

  // init Gsheets
  final gsheets = GSheets(creditionals);

  // fetching a spreadsheet by id
  final workbook = await gsheets.spreadsheet(spreadsheetId);

  // fetching a spreading by it's name
  final spreadSheet = workbook.worksheetByTitle('workbook1');

  await spreadSheet?.values.insertValue("Id", column: 1, row: 1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
