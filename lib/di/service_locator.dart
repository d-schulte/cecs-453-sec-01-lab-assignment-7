// Lab assignment 7 - SQLite, Singleton, Repository, MVVM, and GetIt
// Group: Colin Schulte, Dylan Schulte
// service_locator.dart

import 'package:get_it/get_it.dart';
import 'package:lab_assignment_7/repository/note_repository.dart';

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NoteRepository());
}
