import 'package:json_annotation/json_annotation.dart';

part 'ar.g.dart';

@JsonSerializable()
class Ar {
    Ar();

    num id;
    String name;
    List tns;
    List alias;
    
    factory Ar.fromJson(Map<String,dynamic> json) => _$ArFromJson(json);
    Map<String, dynamic> toJson() => _$ArToJson(this);
}
