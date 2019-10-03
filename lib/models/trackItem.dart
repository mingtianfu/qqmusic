import 'package:json_annotation/json_annotation.dart';
import "ar.dart";
import "al.dart";
part 'trackItem.g.dart';

@JsonSerializable()
class TrackItem {
    TrackItem();

    String name;
    num id;
    num pst;
    num t;
    List<Ar> ar;
    List alia;
    num pop;
    num st;
    String rt;
    num fee;
    num v;
    String crbt;
    String cf;
    Al al;
    num dt;
    Map<String,dynamic> h;
    Map<String,dynamic> m;
    Map<String,dynamic> l;
    String a;
    String cd;
    num no;
    String rtUrl;
    num ftype;
    List rtUrls;
    num djId;
    num copyright;
    num s_id;
    num mark;
    num rtype;
    String rurl;
    num mst;
    num cp;
    num mv;
    num publishTime;
    
    factory TrackItem.fromJson(Map<String,dynamic> json) => _$TrackItemFromJson(json);
    Map<String, dynamic> toJson() => _$TrackItemToJson(this);
}
