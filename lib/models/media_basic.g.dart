// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_basic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaBasicAdapter extends TypeAdapter<MediaBasic> {
  @override
  final int typeId = 1;

  @override
  MediaBasic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MediaBasic(
      id: fields[0] as String,
      cover: fields[1] as String?,
      title: fields[2] as String,
      info: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MediaBasic obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cover)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.info);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaBasicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
