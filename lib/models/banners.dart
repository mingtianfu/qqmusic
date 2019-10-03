import 'package:json_annotation/json_annotation.dart';
import "bannerItem.dart";
part 'banners.g.dart';

@JsonSerializable()
class Banners {
    Banners();

    List<BannerItem> banners;
    num code;
    
    factory Banners.fromJson(Map<String,dynamic> json) => _$BannersFromJson(json);
    Map<String, dynamic> toJson() => _$BannersToJson(this);
}
