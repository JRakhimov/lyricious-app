// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveSongModelAdapter extends TypeAdapter<HiveSongModel> {
  @override
  final int typeId = 3;

  @override
  HiveSongModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveSongModel(
      actionDate: fields[0] as DateTime,
      song: fields[1] as SongModel,
    );
  }

  @override
  void write(BinaryWriter writer, HiveSongModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.actionDate)
      ..writeByte(1)
      ..write(obj.song);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveSongModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HiveSongModel _$HiveSongModelFromJson(Map<String, dynamic> json) {
  return HiveSongModel(
    actionDate: DateTime.parse(json['actionDate'] as String),
    song: SongModel.fromJson(json['song'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HiveSongModelToJson(HiveSongModel instance) =>
    <String, dynamic>{
      'actionDate': instance.actionDate.toIso8601String(),
      'song': instance.song,
    };
