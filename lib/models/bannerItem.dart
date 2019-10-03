import 'package:json_annotation/json_annotation.dart';
import "song.dart";
part 'bannerItem.g.dart';

@JsonSerializable()
class BannerItem {
    BannerItem();

    String pic;
    num targetId;
    String adid;
    num targetType;
    String titleColor;
    String typeTitle;
    String url;
    String adurlV2;
    bool exclusive;
    String monitorImpress;
    String monitorClick;
    String monitorType;
    List monitorImpressList;
    List monitorClickList;
    String monitorBlackList;
    String extMonitor;
    String extMonitorInfo;
    String adSource;
    String adLocation;
    String encodeId;
    String program;
    String event;
    String video;
    Song song;
    String bannerId;
    String alg;
    String scm;
    String requestId;
    bool showAdTag;
    String pid;
    String showContext;
    String adDispatchJson;
    
    factory BannerItem.fromJson(Map<String,dynamic> json) => _$BannerItemFromJson(json);
    Map<String, dynamic> toJson() => _$BannerItemToJson(this);
}
