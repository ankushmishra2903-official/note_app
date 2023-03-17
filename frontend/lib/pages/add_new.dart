import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/note_model.dart';
import '../providers/notes_providers.dart';

class AddNewNotePage extends StatefulWidget {
  final NoteModel? noteModel;

  const AddNewNotePage({Key? key, this.noteModel}) : super(key: key);

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  final TextEditingController _titleController = TextEditingController(),
      _notesController = TextEditingController();

  _submit() {
    int id = 1;
    if(Provider.of<NotesProviders>(context, listen: false).notes.isNotEmpty){
      id = (int.parse(Provider.of<NotesProviders>(context, listen: false)
                  .notes
                  .last
                  .id ??
              "0") +
          1);
    }
    NoteModel note = NoteModel(
        id: widget.noteModel?.id ?? id.toString(),
        userId: "ankushmishra",
        title: _titleController.text,
        content: _notesController.text,
        dateAdded: DateTime.now());
    if (widget.noteModel == null) {
      Provider.of<NotesProviders>(context, listen: false).addNote(note);
    } else {
      Provider.of<NotesProviders>(context, listen: false).updateNote(note);
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.noteModel?.title ?? "";
    _notesController.text = widget.noteModel?.content ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add New Notes"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextFormField(
            autofocus: widget.noteModel == null,
            controller: _titleController,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: "Title",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            maxLines: null,
            controller: _notesController,
            style: TextStyle(
              fontSize: 20,
            ),
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: "Notes",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FilledButton(
            onPressed: _submit,
            child: Text(widget.noteModel == null ? "Submit" : "Update"),
          )
        ],
      ),
    );
  }
}
