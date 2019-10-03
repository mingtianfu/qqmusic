import 'package:json_annotation/json_annotation.dart';
import "toplistdetailtrack.dart";
part 'toplistdetail.g.dart';

@JsonSerializable()
class Toplistdetail {
    Toplistdetail();

    List subscribers;
    String subscribed;
    String creator;
    String artists;
    List<Toplistdetailtrack> tracks;
    String updateFrequency;
    num backgroundCoverId;
    String backgroundCoverUrl;
    bool ordered;
    num status;
    List tags;
    num userId;
    num updateTime;
    num coverImgId;
    bool newImported;
    bool anonimous;
    num specialType;
    String coverImgUrl;
    String commentThreadId;
    num trackCount;
    num privacy;
    num trackUpdateTime;
    num totalDuration;
    num trackNumberUpdateTime;
    num playCount;
    num subscribedCount;
    num cloudTrackCount;
    String name;
    num id;
    String description;
    num createTime;
    bool highQuality;
    num adType;
    String coverImgId_str;
    String ToplistType;
    
    factory Toplistdetail.fromJson(Map<String,dynamic> json) => _$ToplistdetailFromJson(json);
    Map<String, dynamic> toJson() => _$ToplistdetailToJson(this);
}
