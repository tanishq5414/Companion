// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recentlyaccessed.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlyAccessedAdapter extends TypeAdapter<RecentlyAccessed> {
  @override
  final int typeId = 0;

  @override
  RecentlyAccessed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyAccessed(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyAccessed obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.notesid)
      ..writeByte(1)
      ..write(obj.accessed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyAccessedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
