// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongModelAdapter extends TypeAdapter<SongModel> {
  @override
  final int typeId = 0;

  @override
  SongModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongModel(
      name: fields[0] as String,
      artists: (fields[1] as List).cast<String>(),
      lyrics: fields[2] as LyricsModel?,
      albumPic: fields[3] as String?,
      duration: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SongModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.artists)
      ..writeByte(2)
      ..write(obj.lyrics)
      ..writeByte(3)
      ..write(obj.albumPic)
      ..writeByte(4)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongModel _$SongModelFromJson(Map<String, dynamic> json) {
  return SongModel(
    name: json['name'] as String,
    artists:
        (json['artists'] as List<dynamic>).map((e) => e as String).toList(),
    lyrics: json['lyrics'] == null
        ? null
        : LyricsModel.fromJson(json['lyrics'] as Map<String, dynamic>),
    albumPic: json['albumPic'] as String?,
    duration: json['duration'] as int?,
  );
}

Map<String, dynamic> _$SongModelToJson(SongModel instance) => <String, dynamic>{
      'name': instance.name,
      'artists': instance.artists,
      'lyrics': instance.lyrics,
      'albumPic': instance.albumPic,
      'duration': instance.duration,
    };
