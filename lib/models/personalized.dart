import 'package:json_annotation/json_annotation.dart';
import "personalizeditem.dart";
part 'personalized.g.dart';

@JsonSerializable()
class Personalized {
    Personalized();

    bool hasTaste;
    num code;
    num category;
    List<Personalizeditem> result;
    
    factory Personalized.fromJson(Map<String,dynamic> json) => _$PersonalizedFromJson(json);
    Map<String, dynamic> toJson() => _$PersonalizedToJson(this);
}
