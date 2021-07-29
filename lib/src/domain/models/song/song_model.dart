import 'package:json_annotation/json_annotation.dart';

part 'song_model.g.dart';

@JsonSerializable()
class SongModel {
  String name;
  String artist;
  String? album;
  String? albumPic;

  SongModel({
    required this.name,
    required this.artist,
    this.album,
    this.albumPic,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return _$SongModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SongModelToJson(this);
}
