import 'package:json_annotation/json_annotation.dart';

part 'personalizeditem.g.dart';

@JsonSerializable()
class Personalizeditem {
    Personalizeditem();

    num id;
    num type;
    String name;
    String copywriter;
    String picUrl;
    bool canDislike;
    num playCount;
    num trackCount;
    bool highQuality;
    String alg;
    
    factory Personalizeditem.fromJson(Map<String,dynamic> json) => _$PersonalizeditemFromJson(json);
    Map<String, dynamic> toJson() => _$PersonalizeditemToJson(this);
}
