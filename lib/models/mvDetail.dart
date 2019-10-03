import 'package:json_annotation/json_annotation.dart';

part 'mvDetail.g.dart';

@JsonSerializable()
class MvDetail {
    MvDetail();

    num id;
    String name;
    num artistId;
    String artistName;
    String briefDesc;
    String desc;
    String cover;
    num coverId;
    num playCount;
    num subCount;
    num shareCount;
    num likeCount;
    num commentCount;
    num duration;
    num nType;
    String publishTime;
    List artists;
    bool isReward;
    String commentThreadId;
    
    factory MvDetail.fromJson(Map<String,dynamic> json) => _$MvDetailFromJson(json);
    Map<String, dynamic> toJson() => _$MvDetailToJson(this);
}
