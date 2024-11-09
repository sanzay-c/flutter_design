import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // textcontroller to typein
  final textController = TextEditingController();

  // **CREATE - a notes to save in supabase (mehtod)
  void addNewNotes() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add some notes"),
        content: TextField(
          controller: textController,
        ),
        actions: [
          // save button
          TextButton(
            onPressed: () {
              // save notes
              saveNotes();

              // and pop it back
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),

          // cancel Button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  // dispose the controller
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // methods for save notes - save to supabase
  void saveNotes() async {
    try {
      await Supabase.instance.client.from('notes').insert({
        'body': textController.text
      }); // 'notes' is a table name and insert in the bdy column

      // After saving, trigger a state update to refresh the UI
      setState(() {});

      // Optionally clear the text field after saving
      textController.clear();

      // **Manually refresh the data stream** to get the latest notes
      refreshNotes();
    } catch (e) {
      throw Exception("Error inserting note: $e");
    }
  }

  
  // **DELETE - delete a note from supabase
  void deleteNote(int noteId) async {
    try {
      await Supabase.instance.client.from('notes').delete().eq('id', noteId);
      setState(() {
        refreshNotes(); // Refresh the notes after deletion
      });
    } catch (e) {
      throw Exception("Error deleting note: $e");
    }
  }

  // ** READ - a notes form a supabase using "stream"
  var _notesStream =
      Supabase.instance.client.from('notes').stream(primaryKey: ["id"]);

  // Method to refresh (reload) the stream data manually
  void refreshNotes() {
    setState(() {
      _notesStream =
          Supabase.instance.client.from('notes').stream(primaryKey: ["id"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNotes,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notesStream,
        builder: (context, snapshot) {
          // loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
              ),

            );
            
          }
          // Debug log to monitor stream data
          print("Stream data: ${snapshot.data}");

          // loaded
          final notes = snapshot.data!;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              // get the indivisual notes
              final note = notes[index];

              // get the column you want
              final noteText = note['body'];

              // Assuming 'id' is the primary key of the note
              final noteId = note['id'];

              // return as UI
              /**
               * The ?? operator in Dart is called the null-aware operator (specifically, 
               * the null-coalescing operator). It is used to check if the value on the 
               * left-hand side is null. If it is null, 
               * the value on the right-hand side will be 
               * returned instead.
              */
              return ListTile(
                title: Text(noteText ?? 'No Content', style: const TextStyle(fontWeight: FontWeight.bold),),
                 trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Show confirmation dialog before deleting
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirm Deletion'),
                        content: const Text('Are you sure you want to delete this note?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              deleteNote(noteId);
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text("Delete"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog without doing anything
                            },
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
