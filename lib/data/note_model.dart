// Lab assignment 7 - SQLite, Singleton, Repository, MVVM, and GetIt
// Group: Colin Schulte, Dylan Schulte
// note_model.dart

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime date;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      "date": date.toIso8601String(), // Convert date to string
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
    );
  }
}
