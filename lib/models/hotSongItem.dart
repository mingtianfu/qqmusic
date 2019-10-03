import 'package:json_annotation/json_annotation.dart';
import "al.dart";
part 'hotSongItem.g.dart';

@JsonSerializable()
class HotSongItem {
    HotSongItem();

    List rtUrls;
    List ar;
    Al al;
    num st;
    num no;
    num fee;
    num v;
    num djId;
    String cd;
    num mv;
    String a;
    Map<String,dynamic> m;
    num rtype;
    String rurl;
    String crbt;
    String rtUrl;
    num ftype;
    num pst;
    num t;
    List alia;
    num pop;
    String rt;
    num mst;
    num cp;
    String cf;
    num dt;
    Map<String,dynamic> h;
    Map<String,dynamic> l;
    String name;
    num id;
    Map<String,dynamic> privilege;
    
    factory HotSongItem.fromJson(Map<String,dynamic> json) => _$HotSongItemFromJson(json);
    Map<String, dynamic> toJson() => _$HotSongItemToJson(this);
}
