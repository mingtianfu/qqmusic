import 'package:json_annotation/json_annotation.dart';

part 'al.g.dart';

@JsonSerializable()
class Al {
    Al();

    num id;
    String name;
    String picUrl;
    List tns;
    String pic_str;
    num pic;
    
    factory Al.fromJson(Map<String,dynamic> json) => _$AlFromJson(json);
    Map<String, dynamic> toJson() => _$AlToJson(this);
}
