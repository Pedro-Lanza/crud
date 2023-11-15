// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailsAdapter extends TypeAdapter<Details> {
  @override
  final int typeId = 1;

  @override
  Details read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Details(
      id: fields[0] as int?,
      user: fields[1] as int,
      description: fields[2] as String,
      birth: fields[3] as DateTime,
      private: fields[4] as bool,
    )
      ..followers = fields[5] as int
      ..following = fields[6] as int
      ..posts = (fields[7] as List).cast<int>();
  }

  @override
  void write(BinaryWriter writer, Details obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.birth)
      ..writeByte(4)
      ..write(obj.private)
      ..writeByte(5)
      ..write(obj.followers)
      ..writeByte(6)
      ..write(obj.following)
      ..writeByte(7)
      ..write(obj.posts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
