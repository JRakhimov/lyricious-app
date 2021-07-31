// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_line_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LyricsLineModelAdapter extends TypeAdapter<LyricsLineModel> {
  @override
  final int typeId = 2;

  @override
  LyricsLineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LyricsLineModel(
      text: fields[0] as String,
      startTime: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, LyricsLineModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.startTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LyricsLineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LyricsLineModel _$LyricsLineModelFromJson(Map<String, dynamic> json) {
  return LyricsLineModel(
    text: json['text'] as String,
    startTime: (json['startTime'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$LyricsLineModelToJson(LyricsLineModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'startTime': instance.startTime,
    };
