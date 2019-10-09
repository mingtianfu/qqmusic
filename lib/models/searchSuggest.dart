import 'package:json_annotation/json_annotation.dart';

part 'searchSuggest.g.dart';

@JsonSerializable()
class SearchSuggest {
    SearchSuggest();

    String keyword;
    num type;
    String alg;
    String lastKeyword;
    
    factory SearchSuggest.fromJson(Map<String,dynamic> json) => _$SearchSuggestFromJson(json);
    Map<String, dynamic> toJson() => _$SearchSuggestToJson(this);
}
