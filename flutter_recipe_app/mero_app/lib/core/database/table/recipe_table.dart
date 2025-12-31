import 'package:drift/drift.dart';

class Recipes extends Table {
  // Primary Key
  IntColumn get id => integer().autoIncrement()();
  
  // Recipe Details
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get cuisine => text().nullable()();
  TextColumn get difficulty => text().nullable()();
  TextColumn get image => text().nullable()();
  
  // JSON columns for lists
  TextColumn get ingredients => text()();  // Store as JSON array
  TextColumn get instructions => text()(); // Store as JSON array
  TextColumn get tags => text().nullable()();
  TextColumn get mealType => text().nullable()();
  
  // Numeric fields
  IntColumn get prepTimeMinutes => integer().withDefault(const Constant(0))();
  IntColumn get cookTimeMinutes => integer().withDefault(const Constant(0))();
  IntColumn get servings => integer().withDefault(const Constant(0))();
  IntColumn get caloriesPerServing => integer().withDefault(const Constant(0))();
  IntColumn get userId => integer().withDefault(const Constant(0))();
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  
  RealColumn get rating => real().withDefault(const Constant(0.0))();
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  
  // Remote ID (from API)
  IntColumn get remoteId => integer().nullable()();
}
