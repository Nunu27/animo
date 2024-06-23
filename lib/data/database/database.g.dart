// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MediaTableTable extends MediaTable
    with TableInfo<$MediaTableTable, MediaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _coverMeta = const VerificationMeta('cover');
  @override
  late final GeneratedColumn<String> cover = GeneratedColumn<String>(
      'cover', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<MediaType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<MediaType>($MediaTableTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [id, cover, title, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_table';
  @override
  VerificationContext validateIntegrity(Insertable<MediaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cover')) {
      context.handle(
          _coverMeta, cover.isAcceptableOrUnknown(data['cover']!, _coverMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cover: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: $MediaTableTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
    );
  }

  @override
  $MediaTableTable createAlias(String alias) {
    return $MediaTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MediaType, int, int> $convertertype =
      const EnumIndexConverter<MediaType>(MediaType.values);
}

class MediaTableData extends DataClass implements Insertable<MediaTableData> {
  final int id;
  final String? cover;
  final String title;
  final MediaType type;
  const MediaTableData(
      {required this.id, this.cover, required this.title, required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || cover != null) {
      map['cover'] = Variable<String>(cover);
    }
    map['title'] = Variable<String>(title);
    {
      map['type'] = Variable<int>($MediaTableTable.$convertertype.toSql(type));
    }
    return map;
  }

  MediaTableCompanion toCompanion(bool nullToAbsent) {
    return MediaTableCompanion(
      id: Value(id),
      cover:
          cover == null && nullToAbsent ? const Value.absent() : Value(cover),
      title: Value(title),
      type: Value(type),
    );
  }

  factory MediaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaTableData(
      id: serializer.fromJson<int>(json['id']),
      cover: serializer.fromJson<String?>(json['cover']),
      title: serializer.fromJson<String>(json['title']),
      type: $MediaTableTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cover': serializer.toJson<String?>(cover),
      'title': serializer.toJson<String>(title),
      'type':
          serializer.toJson<int>($MediaTableTable.$convertertype.toJson(type)),
    };
  }

  MediaTableData copyWith(
          {int? id,
          Value<String?> cover = const Value.absent(),
          String? title,
          MediaType? type}) =>
      MediaTableData(
        id: id ?? this.id,
        cover: cover.present ? cover.value : this.cover,
        title: title ?? this.title,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('MediaTableData(')
          ..write('id: $id, ')
          ..write('cover: $cover, ')
          ..write('title: $title, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cover, title, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaTableData &&
          other.id == this.id &&
          other.cover == this.cover &&
          other.title == this.title &&
          other.type == this.type);
}

class MediaTableCompanion extends UpdateCompanion<MediaTableData> {
  final Value<int> id;
  final Value<String?> cover;
  final Value<String> title;
  final Value<MediaType> type;
  const MediaTableCompanion({
    this.id = const Value.absent(),
    this.cover = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
  });
  MediaTableCompanion.insert({
    this.id = const Value.absent(),
    this.cover = const Value.absent(),
    required String title,
    required MediaType type,
  })  : title = Value(title),
        type = Value(type);
  static Insertable<MediaTableData> custom({
    Expression<int>? id,
    Expression<String>? cover,
    Expression<String>? title,
    Expression<int>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cover != null) 'cover': cover,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
    });
  }

  MediaTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? cover,
      Value<String>? title,
      Value<MediaType>? type}) {
    return MediaTableCompanion(
      id: id ?? this.id,
      cover: cover ?? this.cover,
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cover.present) {
      map['cover'] = Variable<String>(cover.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] =
          Variable<int>($MediaTableTable.$convertertype.toSql(type.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaTableCompanion(')
          ..write('id: $id, ')
          ..write('cover: $cover, ')
          ..write('title: $title, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  _$DatabaseManager get managers => _$DatabaseManager(this);
  late final $MediaTableTable mediaTable = $MediaTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [mediaTable];
}

typedef $$MediaTableTableInsertCompanionBuilder = MediaTableCompanion Function({
  Value<int> id,
  Value<String?> cover,
  required String title,
  required MediaType type,
});
typedef $$MediaTableTableUpdateCompanionBuilder = MediaTableCompanion Function({
  Value<int> id,
  Value<String?> cover,
  Value<String> title,
  Value<MediaType> type,
});

class $$MediaTableTableTableManager extends RootTableManager<
    _$Database,
    $MediaTableTable,
    MediaTableData,
    $$MediaTableTableFilterComposer,
    $$MediaTableTableOrderingComposer,
    $$MediaTableTableProcessedTableManager,
    $$MediaTableTableInsertCompanionBuilder,
    $$MediaTableTableUpdateCompanionBuilder> {
  $$MediaTableTableTableManager(_$Database db, $MediaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MediaTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MediaTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$MediaTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> cover = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<MediaType> type = const Value.absent(),
          }) =>
              MediaTableCompanion(
            id: id,
            cover: cover,
            title: title,
            type: type,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> cover = const Value.absent(),
            required String title,
            required MediaType type,
          }) =>
              MediaTableCompanion.insert(
            id: id,
            cover: cover,
            title: title,
            type: type,
          ),
        ));
}

class $$MediaTableTableProcessedTableManager extends ProcessedTableManager<
    _$Database,
    $MediaTableTable,
    MediaTableData,
    $$MediaTableTableFilterComposer,
    $$MediaTableTableOrderingComposer,
    $$MediaTableTableProcessedTableManager,
    $$MediaTableTableInsertCompanionBuilder,
    $$MediaTableTableUpdateCompanionBuilder> {
  $$MediaTableTableProcessedTableManager(super.$state);
}

class $$MediaTableTableFilterComposer
    extends FilterComposer<_$Database, $MediaTableTable> {
  $$MediaTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cover => $state.composableBuilder(
      column: $state.table.cover,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<MediaType, MediaType, int> get type =>
      $state.composableBuilder(
          column: $state.table.type,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$MediaTableTableOrderingComposer
    extends OrderingComposer<_$Database, $MediaTableTable> {
  $$MediaTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cover => $state.composableBuilder(
      column: $state.table.cover,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$DatabaseManager {
  final _$Database _db;
  _$DatabaseManager(this._db);
  $$MediaTableTableTableManager get mediaTable =>
      $$MediaTableTableTableManager(_db, _db.mediaTable);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'e4fbcd79c505e8d87cac73397a38be8a6f405b5f';

/// See also [database].
@ProviderFor(database)
final databaseProvider = AutoDisposeProvider<Database>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DatabaseRef = AutoDisposeProviderRef<Database>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
