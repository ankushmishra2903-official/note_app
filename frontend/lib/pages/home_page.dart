import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/functions.dart';
import '../model/note_model.dart';
import '../providers/notes_providers.dart';
import 'add_new.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProviders notesProviders = Provider.of<NotesProviders>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flutter Node.js Demo'),
      ),
      body: notesProviders.isLoading ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text("Loading......")
          ],
        ),
      ) : ListView(
        padding: EdgeInsets.all(10),
        children: [
          for (NoteModel note in notesProviders.notes) ...[
            Container(
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AddNewNotePage(
                        noteModel: note,
                      ),
                    ),
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Confirmation for Delete Note"),
                      content: Text(
                          "Are you sure to delete note ${note.title}"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            notesProviders.deleteNote(note);
                            Navigator.of(context).pop();
                          },
                          child: Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.red),
                          ),
                          child: Text("No"),
                        ),
                      ],
                    ),
                  );
                },
                title: Text(note.title?.trim() ?? ""),
                subtitle: Text(note.content?.trim() ?? ""),
                trailing: Text(Fun.myDateFormat(note.dateAdded)),
              ),
            )
          ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => AddNewNotePage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
