import 'package:animo/data/database/connection.dart';
import 'package:animo/data/database/tables/media_table.dart';
import 'package:animo/domain/enums/media_type.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

@riverpod
Database database(DatabaseRef ref) {
  return Database();
}

@DriftDatabase(tables: [MediaTable])
class Database extends _$Database {
  Database() : super(openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {},
    );
  }
}
