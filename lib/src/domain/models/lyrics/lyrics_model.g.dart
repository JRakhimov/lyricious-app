// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LyricsModelAdapter extends TypeAdapter<LyricsModel> {
  @override
  final int typeId = 1;

  @override
  LyricsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LyricsModel(
      service: fields[0] as String,
      lines: (fields[1] as List).cast<LyricsLineModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, LyricsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.service)
      ..writeByte(1)
      ..write(obj.lines);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LyricsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LyricsModel _$LyricsModelFromJson(Map<String, dynamic> json) {
  return LyricsModel(
    service: json['service'] as String,
    lines: (json['lines'] as List<dynamic>)
        .map((e) => LyricsLineModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LyricsModelToJson(LyricsModel instance) =>
    <String, dynamic>{
      'service': instance.service,
      'lines': instance.lines,
    };
