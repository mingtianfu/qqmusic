
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/utils/HttpUtils.dart';
import 'package:qqmusic/utils/utils.dart';

class LoginPage extends StatefulWidget{
  @override 
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey= new GlobalKey<FormState>();
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;
  bool _unameIsinput = false;

    String _name;

  String _password;

  void _forSubmitted() async{
    try {
      var result = await HttpUtils.request("/login/cellphone?phone=$_name&password=$_password");
      if (result != null) {
        var data = json.decode(result);
        if (data['code'] == 200) {
          Toast.toast(context, '登录成功 ');
          Navigator.of(context).pop();
          print(data['account']);
          print(data['profile']);
        }
      } else {
        Toast.toast(context, '登录失败');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('assets/images/back_normal_black.png', width: 30,),
              onPressed: () { Navigator.of(context).pop(); },
            );
          },
        ),
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        title: Text('手机号登录', style: TextStyle(color: Colors.black87),),
      ),
      body: SafeArea(
        child: Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Colors.red,
            hintColor: Colors.transparent, //定义下划线颜色
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.grey),//定义label字体样式
                hintStyle: TextStyle(color: Colors.grey)//定义提示文本样式
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: Text('未注册手机号登录后将自动创建账号', style: TextStyle(color: Colors.grey),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                child: Form(
                  key: _formKey, //设置globalKey，用于后面获取FormState
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              right: 0,
                              left: 0,
                              bottom: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  // 下滑线浅灰色，宽度1像素
                                  border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
                                ),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              maxLength: 11,
                              maxLines: 1,
                              autofocus: true,
                              controller: _unameController,
                              textInputAction: TextInputAction.next,
                              focusNode: focusNode1,
                              decoration: InputDecoration(
                                hintText: "请输入手机号",
                                border: InputBorder.none,
                                prefixIcon: Container(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text('+86', style: TextStyle(fontSize: 16, color: _unameIsinput ? Colors.black : Colors.grey),), // myIcon is a 48px-wide widget.
                                ),
                                suffixIcon: _unameIsinput ? IconButton(
                                  icon: Icon(Icons.close, color: Colors.grey[400],),
                                  onPressed: () {
                                    _unameController.clear();
                                  },
                                ) : null,
                              ),
                              onChanged: (v) {
                                if (v.trim().length > 0) {
                                  setState(() {
                                    _unameIsinput = true;
                                  });
                                }
                              },
                              onSaved: (val) {
                                _name = val;
                              },
                              validator: (v) {
                                return isChinaPhoneLegal(v.trim()) ? null : "手机号不正确";
                              }

                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              right: 0,
                              left: 0,
                              bottom: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  // 下滑线浅灰色，宽度1像素
                                  border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
                                ),
                              ),
                            ),
                            TextFormField(
                              maxLength: 20,
                              maxLines: 1,
                              obscureText: true,
                              controller: _pwdController,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: "请输入密码",
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.close, color: Colors.grey[400],),
                                  onPressed: () {
                                    _pwdController.clear();
                                  },
                                ),
                              ),
                              onSaved: (val) {
                                _password = val;
                              },
                              validator: (v) {
                                return v
                                    .trim()
                                    .length > 0 ? null : "密码不能为空";
                              }

                            )
                          ],
                        ),
                      ),
                      // 登录按钮
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                padding: EdgeInsets.all(15.0),
                                child: Text("登录"),
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  //在这里不能通过此方式获取FormState，context不对
                                  // print(Form.of(context));

                                  // 通过_formKey.currentState 获取FormState后，
                                  // 调用validate()方法校验用户名密码是否合法，校验
                                  // 通过后再提交数据。 
                                  
                                  if((_formKey.currentState as FormState).validate()){
                                      (_formKey.currentState as FormState).save();
                                      _forSubmitted();
                                    //验证通过提交数据
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}