import 'package:animo/domain/enums/media_type.dart';
import 'package:drift/drift.dart';

class MediaTable extends Table {
  IntColumn get id => integer()();
  TextColumn get cover => text().nullable()();
  TextColumn get title => text()();
  IntColumn get type => intEnum<MediaType>()();

  @override
  Set<Column> get primaryKey => {id};
}
