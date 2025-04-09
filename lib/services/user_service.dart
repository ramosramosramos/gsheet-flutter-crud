import 'package:flutter_gsheets/configuration.dart';
import 'package:gsheets/gsheets.dart';

class UserService {
  Spreadsheet? spreadsheet;
  Future<Worksheet?> worksheet({required title}) async {
    final GSheets gsheets = GSheets(credentials);
    spreadsheet = await gsheets.spreadsheet(spreadsheetId);
    return spreadsheet!.worksheetByTitle(title);
  }

  Stream getUserStream() async* {
    final users = await worksheet(title: 'users');
    yield await users!.values.allRows(fromRow: 2);
  }

  void store({
    required String name,
    required String email,
    required String password,
  }) async {
    final users = await worksheet(title: 'users');
    await users!.values.appendRow([name, email, password]);
  }

  void update({
    required int id,
    required String name,
    required String email,
    required String password,
  }) async {
    final users = await worksheet(title: 'users');
    await users!.values.insertRow(id, [name, email, password]);
  }

  void destroy({required int id}) async{
       final users = await worksheet(title: 'users');
       await users!.values.insertRow(id, ['','','']);
      getUserStream();
  }
}
