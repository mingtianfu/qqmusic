import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
    Account();

    num id;
    String userName;
    num type;
    num status;
    num whitelistAuthority;
    num createTime;
    String salt;
    num tokenVersion;
    num ban;
    num baoyueVersion;
    num donateVersion;
    num vipType;
    num viptypeVersion;
    bool anonimousUser;
    
    factory Account.fromJson(Map<String,dynamic> json) => _$AccountFromJson(json);
    Map<String, dynamic> toJson() => _$AccountToJson(this);
}
