// Lab assignment 7 - SQLite, Singleton, Repository, MVVM, and GetIt
// Group: Colin Schulte, Dylan Schulte
// note_repository.dart

import 'package:lab_assignment_7/data/db_helper.dart';
import 'package:lab_assignment_7/data/note_model.dart';

class NoteRepository {
  final DBHelper _dbHelper = DBHelper();
  Future<List<Note>> getNotes() => _dbHelper.getNotes();
  Future<int> insertNote(Note note) => _dbHelper.insertNote(note);
  Future<int> updateNote(Note note) => _dbHelper.updateNote(note);
  Future<int> deleteNote(int id) => _dbHelper.deleteNote(id);
}
