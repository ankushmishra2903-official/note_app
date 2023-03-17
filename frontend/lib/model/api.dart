import 'dart:convert';

import 'package:http/http.dart' as http;

import 'note_model.dart';

class Api {
  static const String _baseUrl = "https://node.sacchasauda.com/note";

  static Uri _toUri(String url) => Uri.parse(url);

  static Future addNote(NoteModel note) async{
    var res = await http.post(
      _toUri("$_baseUrl/add"),
      body: note.toMap(),
    );
    print(jsonDecode(res.body));
  }

  static Future<List<NoteModel>> getNote() async{
    var res = await http.post(
      _toUri(_baseUrl),
      body: {
        "user_id" : "ankushmishra"
      },
    );
    List data = jsonDecode(res.body);
    List<NoteModel> notes = [];
    for(Map<String, dynamic> map in data) {
      notes.add(NoteModel.fromMap(map));
    }
    return notes;
  }

  static Future updateNote(NoteModel note) async{
    var res = await http.post(
      _toUri("$_baseUrl/update"),
      body: note.toMap(),
    );
    print(jsonDecode(res.body));
  }

  static Future deleteNote(NoteModel note) async{
    var res = await http.post(
      _toUri("$_baseUrl/delete"),
      body: note.toMap(),
    );
    print(jsonDecode(res.body));
  }
}
