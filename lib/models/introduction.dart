import 'package:json_annotation/json_annotation.dart';

part 'introduction.g.dart';

@JsonSerializable()
class Introduction {
    Introduction();

    String ti;
    String txt;
    
    factory Introduction.fromJson(Map<String,dynamic> json) => _$IntroductionFromJson(json);
    Map<String, dynamic> toJson() => _$IntroductionToJson(this);
}
