import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gsheets/gsheets.dart';

//? speardsheet id, got from url: https://docs.google.com/spreadsheets/d/1TZiWjji3QR81u1EcZaX_RrQBoJgheoZmjRR1t_mVCM4/edit?gid=0#gid=0
const spreadsheetId = '1TZiWjji3QR81u1EcZaX_RrQBoJgheoZmjRR1t_mVCM4';

void main() async {
  // loading secret file
  await dotenv.load();

  // loading secret data
  String creditionals = dotenv.env['API_KEY'] ?? "";

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
