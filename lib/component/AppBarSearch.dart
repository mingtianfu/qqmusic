import 'package:flutter/material.dart';

class AppBarSearch extends StatelessWidget {
  AppBarSearch({
    this.title,
    this.rightImage,
    this.onPressedRight,
    this.onPressed,
  });

  final String title;
  final Image rightImage;
  final GestureTapCallback onPressedRight;
  final GestureTapCallback onPressed;

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                new Text(title, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed('searchPage'),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/label_search_icon.png', width: 24,),
                          Text('搜索', style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: rightImage,
                  onTap: onPressedRight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}