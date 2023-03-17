import 'package:flutter/material.dart';

import '../model/api.dart';
import '../model/note_model.dart';

class NotesProviders with ChangeNotifier {
  List<NoteModel> notes = [];
  bool isLoading = true;

  NotesProviders(){
    fetchNotes();
  }

  void sortNote(){
    notes.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded!),);
  }

  void addNote(NoteModel note) {
    notes.add(note);
    sortNote();
    notifyListeners();
    Api.addNote(note);
  }
  void updateNote(NoteModel note) {
    int index = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[index] = note;
    sortNote();
    notifyListeners();
    Api.updateNote(note);
  }
  void deleteNote(NoteModel note) {
    int index = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(index);
    sortNote();
    notifyListeners();
    Api.deleteNote(note);
  }

  void fetchNotes() async {
    notes =  await Api.getNote();
    sortNote();
    isLoading = false;
    notifyListeners();
  }
}