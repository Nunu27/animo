import 'package:animo/domain/enums/media_type.dart';
import 'package:drift/drift.dart';

class ExtensionTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  TextColumn get type => textEnum<MediaType>()();
  TextColumn get baseUrl => text()();
  TextColumn get apiUrl => text().nullable()();
  TextColumn get lang => text()();
  TextColumn get sourceCode => text().nullable()();
  BoolColumn get enabled => boolean().withDefault(const Constant(false))();
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();
  BoolColumn get nsfw => boolean().withDefault(const Constant(false))();
  BoolColumn get local => boolean().withDefault(const Constant(false))();
  TextColumn get version => text()();

  @override
  Set<Column> get primaryKey => {id};
}
