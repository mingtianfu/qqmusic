import 'package:json_annotation/json_annotation.dart';

part 'toplistdetailtrack.g.dart';

@JsonSerializable()
class Toplistdetailtrack {
    Toplistdetailtrack();

    String first;
    String second;
    
    factory Toplistdetailtrack.fromJson(Map<String,dynamic> json) => _$ToplistdetailtrackFromJson(json);
    Map<String, dynamic> toJson() => _$ToplistdetailtrackToJson(this);
}
