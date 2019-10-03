import 'package:json_annotation/json_annotation.dart';

part 'playlistItem.g.dart';

@JsonSerializable()
class PlaylistItem {
    PlaylistItem();

    String name;
    num id;
    num trackNumberUpdateTime;
    num status;
    num userId;
    num createTime;
    num updateTime;
    num subscribedCount;
    num trackCount;
    num cloudTrackCount;
    String coverImgUrl;
    num coverImgId;
    String description;
    List tags;
    num playCount;
    num trackUpdateTime;
    num specialType;
    num totalDuration;
    Map<String,dynamic> creator;
    String tracks;
    List subscribers;
    String subscribed;
    String commentThreadId;
    bool newImported;
    num adType;
    bool highQuality;
    num privacy;
    bool ordered;
    bool anonimous;
    num coverStatus;
    num shareCount;
    String coverImgId_str;
    num commentCount;
    String alg;
    
    factory PlaylistItem.fromJson(Map<String,dynamic> json) => _$PlaylistItemFromJson(json);
    Map<String, dynamic> toJson() => _$PlaylistItemToJson(this);
}
