import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:recipe_app/core/database/tables/recipe_table.dart';

part 'app_database.g.dart'; // generate automatic code

@DriftDatabase(
  tables: [
    Recipes, // used recipe table and register table here.  
  ],
  
)
class AppDatabase extends _$AppDatabase {
  // Private constructor for singleton whole app has only one instance
  AppDatabase._internal() : super(_openConnection());
  
  // Singleton instance 
  static final AppDatabase _instance = AppDatabase._internal();
  
  // Factory constructor returns singleton
  factory AppDatabase() => _instance;

  @override 
  int get schemaVersion => 1; // Database version (schema change भएमा बढाउने)

  // Migration strategy
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      // पहिलो पटक create गर्दा
      onCreate: (Migrator m) async { 
        await m.createAll();  // सबै tables बनाउ
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle migrations here when you update schema
        // Example for version 2:
        // if (from < 2) {
        //   await m.addColumn(recipes, recipes.newColumn);
        // }
      },
      beforeOpen: (details) async {
        // Enable foreign keys
        await customStatement('PRAGMA foreign_keys = ON');
        
        // Print database info (debug only)
        print('📊 Database opened: ${details.wasCreated ? "Created" : "Existing"}');
        print('📊 Database version: ${details.versionNow}');
      },
    );
  }
}

// Database connection
QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'recipe_app_database',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}