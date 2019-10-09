import 'package:json_annotation/json_annotation.dart';

part 'bannerItem.g.dart';

@JsonSerializable()
class BannerItem {
    BannerItem();

    String imageUrl;
    num targetId;
    String adid;
    num targetType;
    String titleColor;
    String typeTitle;
    String url;
    bool exclusive;
    String monitorImpress;
    String monitorClick;
    String monitorType;
    String monitorImpressList;
    String monitorClickList;
    String monitorBlackList;
    String extMonitor;
    String extMonitorInfo;
    String adSource;
    String adLocation;
    String adDispatchJson;
    String encodeId;
    String program;
    String event;
    String video;
    String song;
    String scm;
    
    factory BannerItem.fromJson(Map<String,dynamic> json) => _$BannerItemFromJson(json);
    Map<String, dynamic> toJson() => _$BannerItemToJson(this);
}
