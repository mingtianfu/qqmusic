import 'package:json_annotation/json_annotation.dart';
import "creator.dart";
import "trackItem.dart";
part 'playlistdetailp.g.dart';

@JsonSerializable()
class Playlistdetailp {
    Playlistdetailp();

    List subscribers;
    bool subscribed;
    Creator creator;
    List<TrackItem> tracks;
    List trackIds;
    String updateFrequency;
    num backgroundCoverId;
    String backgroundCoverUrl;
    num subscribedCount;
    num cloudTrackCount;
    num createTime;
    bool highQuality;
    num privacy;
    num trackUpdateTime;
    num userId;
    num updateTime;
    num coverImgId;
    bool newImported;
    num specialType;
    String coverImgUrl;
    num trackCount;
    String commentThreadId;
    num playCount;
    num trackNumberUpdateTime;
    num adType;
    bool ordered;
    List tags;
    String description;
    num status;
    String name;
    num id;
    num shareCount;
    String coverImgId_str;
    num commentCount;
    
    factory Playlistdetailp.fromJson(Map<String,dynamic> json) => _$PlaylistdetailpFromJson(json);
    Map<String, dynamic> toJson() => _$PlaylistdetailpToJson(this);
}
