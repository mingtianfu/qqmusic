import 'package:json_annotation/json_annotation.dart';

part 'lyric.g.dart';

@JsonSerializable()
class Lyric {
    Lyric();

    bool sgc;
    bool sfy;
    bool qfy;
    Map<String,dynamic> lrc;
    Map<String,dynamic> klyric;
    Map<String,dynamic> tlyric;
    num code;
    
    factory Lyric.fromJson(Map<String,dynamic> json) => _$LyricFromJson(json);
    Map<String, dynamic> toJson() => _$LyricToJson(this);
}
