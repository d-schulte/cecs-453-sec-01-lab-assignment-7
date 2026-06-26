import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab_assignment_7/providers/note_provider.dart';
import 'package:lab_assignment_7/ui/add_note_screen.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: Consumer<NoteProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.notes.isEmpty) {
            return const Center(child: Text('No notes yet. Tap + to add one!'));
          } else {
            return ListView.builder(
              itemCount: provider.notes.length,
              itemBuilder: (context, index) {
                final note = provider.notes[index];
                return Card(
                  // ... UI for the note card
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(note.description),
                        const SizedBox(height: 4),
                        Text(
                          '${note.date.month}/${note.date.day}/${note.date.year}',
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddNoteScreen(note: note),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Call the provider to delete the note
                            Provider.of<NoteProvider>(
                              context,
                              listen: false,
                            ).deleteNote(note.id!);
                          },
                          //Provider.of<NoteProvider>(context, listen: false) is a Flutter method used to fetch a
                          //specific NoteProvider instance without triggering widget rebuilds when state changes.
                          //The listen: false flag isolates your UI from data updates, preventing expensive or
                          //unnecessary UI redraws when you only need to trigger a method.
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
        },
      ),
    );
  }
}
