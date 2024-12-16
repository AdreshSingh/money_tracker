import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

const _creditionals = r'''
{
  "type": "service_account",
  "project_id": "flutter-expense-tracker-444421",
  "private_key_id": "dae4beea3d0b31f1b015919b83e23c71c24b8e1e",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDfC258R0mB0ZIN\n+qT9uvKCk9bPw1arpZN7uqz+vvXEJde2YJcceAs/q1ZwYcfuv9KAs8ly+dBuaWfQ\n0w1ySN4KtAk4MHKYeNSEhkkyzYel05HqLOcWVCTMoE9EcTnTnigKvp9fwUfImg13\nWOX6PoUQ4R0QDCFVWBu3z9p+H7xm49EUOsf+2/BmKLeEmuqEh/H6MBcDAbvlgGuh\nQRfnYnt9wt67IzBxedr/YyK9DQLAsy3DWeehY5ruJHArpY3w7Y3FUSz4ZT5uofxo\nk+jcs0fL7rwE45aCfGJXk/YM0u/P10385VuU3o33UNxMB3MzO0/nqmSHWo3IIOhl\nT6zTPxK7AgMBAAECggEAEPu1BHfbHtbpyPBfqsWW3J7MLv1f4T8AzV2H+aJpt+9C\nZGvTZcK1keSxIWqDR5MfQKyFN3Ynyu3HZA0F9kCaePR/dTdUf8vyMUsWUhd4mjBT\naSIqewvvfLiXgI3Mij1TLYpD5rh4B6FvSrn1UkomEK8gwDg5kN7eHBoSuCLLfNv8\niyJba/H9SF81LyacfNZgeRjR5LqiHbKNZtcOV4hvml147whzHP+P06QHYDSfbO/a\ncubdKknrPWKjsbtnJqiikLiCeyTca+79mjHRJxW5htvYEWQSaQoBsvQKyh1aXLzN\n1xlcicSAw0qw9R1qpzrmwNxtsfE4yTzYMutTSpvtSQKBgQDxSQJqouH7gPYoNaci\n2Eb6LPVyakKuTq2vLa7mLbQRFCMuR63nvKOYlIOeoYPmzuciBWkMiLRb/eFG2KmY\n/cq+qyYBRqVvWuOd6nam6AWNB9FzOH6e5sjz+A7HwyhompZRYpu97qexX0gNfvTW\n80J+CRZRWVJXd4529LS5qIDTuQKBgQDspaW6DZN63bvUXd2cYtcx/J22yfN3Azr9\n1wdQOkl1BDTkILluA2vCXCycpJyUZV0YsN5kg9+aob51gzgaxb7jllR94zhPsvF/\nReAj9VWxBe53rxX7i0wkRWMc9QVZWVOy8rhOu7ugeKHO+TTbZv31lBjoOwHFTztE\n4UuESJA8EwKBgBsgYi0q8s0bypDqt0ermQ83TsD2QVjnb49qS2eFa+EfqnThiiOr\niZj12XZUIkgoqsOgaBcIp35QJKuaYDbbEZguFa+/CYpjZYOzgHNzUmxwnJOfnlyv\nBZioIsFCp6BbANtVgrzvv9qpI6igxVYFM0yIKQIsUJ2Uy2eES200DIfBAoGAQUne\nNDuEodRE+u0+s+OtHVRlqsWCzyXsA5ZspRy/oXIcqYfBwPFerIvDnx/nNyXUDnjV\nkoOzkDTpmAAw3WoLJT0XaHfk1FA5QnTjxufr0WAij5CVjwW6ZxNhqd6LsD/t0KQY\nZ1hyBm7hrXmhtJpwnG1UhdWpwmb+oh1KOV/Ps1MCgYARREf2s2TwDcmC96Z9Td+k\nk/bv8mjU4FWXh4BiEUjmMiyGgvfKUmQfkv/eTjRX4o+CC8IGbDG7Tz79g74w5Qo6\nOeUvobyANAUy6oZnEkscM9lkkt7T+q0yayP9c7G8O0c1yV61kKOjC9yvDLjErbIp\nT14HQlqFBwbUcX656Nd6sA==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheet@flutter-expense-tracker-444421.iam.gserviceaccount.com",
  "client_id": "112515971688529126990",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheet%40flutter-expense-tracker-444421.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

''';

//? speardsheet id, got from url: https://docs.google.com/spreadsheets/d/1TZiWjji3QR81u1EcZaX_RrQBoJgheoZmjRR1t_mVCM4/edit?gid=0#gid=0
const spreadsheetId = '1TZiWjji3QR81u1EcZaX_RrQBoJgheoZmjRR1t_mVCM4';

void main() async {
  // init Gsheets
  final gsheets = GSheets(_creditionals);

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
