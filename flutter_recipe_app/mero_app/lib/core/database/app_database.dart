import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:mero_app/core/database/table/recipe_table.dart';

part 'app_database.g.dart'; // generate automatic code

@DriftDatabase(tables: [Recipes])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal(): super(_openConnection());
  
  static final AppDatabase _instance = AppDatabase._internal();
  
  factory AppDatabase() => _instance;

  @override
  int get schemaVersion => 1;

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