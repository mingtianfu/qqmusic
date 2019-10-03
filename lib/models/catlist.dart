import 'package:json_annotation/json_annotation.dart';
import "catItem.dart";
part 'catlist.g.dart';

@JsonSerializable()
class Catlist {
    Catlist();

    CatItem all;
    List<CatItem> sub;
    Map<String,dynamic> categories;
    num code;
    
    factory Catlist.fromJson(Map<String,dynamic> json) => _$CatlistFromJson(json);
    Map<String, dynamic> toJson() => _$CatlistToJson(this);
}
