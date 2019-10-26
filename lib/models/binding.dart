import 'package:json_annotation/json_annotation.dart';

part 'binding.g.dart';

@JsonSerializable()
class Binding {
    Binding();

    num refreshTime;
    String tokenJsonStr;
    num userId;
    String url;
    bool expired;
    num expiresIn;
    num bindingTime;
    num id;
    num type;
    
    factory Binding.fromJson(Map<String,dynamic> json) => _$BindingFromJson(json);
    Map<String, dynamic> toJson() => _$BindingToJson(this);
}
