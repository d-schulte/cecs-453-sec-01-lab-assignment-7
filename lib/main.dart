import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab_assignment_7/di/service_locator.dart';
import 'package:lab_assignment_7/providers/note_provider.dart';
import 'package:lab_assignment_7/ui/note_list_screen.dart';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  setupLocator(); // Set up our dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          NoteProvider()..fetchNotes(), // Create and fetch initial data
      //link to cascade notation
      child: MaterialApp(
        title: 'Sqflite Note Saver',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.system,
        home: const NoteListScreen(),
      ),
    );
  }
}
