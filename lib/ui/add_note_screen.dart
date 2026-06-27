// Lab assignment 7 - SQLite, Singleton, Repository, MVVM, and GetIt
// Group: Colin Schulte, Dylan Schulte
// add_note_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab_assignment_7/providers/note_provider.dart';
import 'package:lab_assignment_7/data/note_model.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;

  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        id: widget.note?.id,
        title: _titleController.text,
        description: _descriptionController.text,
        date: widget.note?.date ?? DateTime.now(), // Default date for new note
      );

      final provider = Provider.of<NoteProvider>(context, listen: false);

      // Upsert note
      if (widget.note == null) {
        await provider.addNote(note);
      } else {
        await provider.updateNote(note);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // Load existing note data
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Fields for title and description
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveNote,
                child: Text(isEditing ? 'Update Note' : 'Save Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
