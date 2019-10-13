import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DataAppPageState();
  }
}

class _DataAppPageState extends State<DataAppPage> {
  List<User> _datas = new List();
  var db = DatabaseHelper();
  Future<Null> _refresh() async {
    _query();
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDb();
  }

  _getDataFromDb() async {
    List datas = await db.getTotalList();
    if (datas.length > 0) {
      //数据库有数据
      datas.forEach((user) {
        User item = User.fromMap(user);
        _datas.add(item);
      });
    } else {
      //数据库没有数据
      User user = new User();
      user.name = "张三";
      user.age = 10;
      user.id = 1;

      User user2 = new User();
      user2.name = "李四";
      user2.age = 12;
      user2.id = 2;

      await db.saveItem(user);
      await db.saveItem(user2);

      _datas.add(user);
      _datas.add(user2);
    }

    setState(() {});
  }

//添加
  Future<Null> _add() async {
    User user = new User();
    user.name = "我是增加的";
    user.age = 33;
    await db.saveItem(user);
    _query();
  }

//删除,默认删除第一条数据
  Future<Null> _delete() async {
    List datas = await db.getTotalList();
    if (datas.length > 0) {
      //修改第一条数据
      User user = User.fromMap(datas[0]);
      db.deleteItem(user.id);
      _query();
    }

  }

//修改，默认修改第一条数据
  Future<Null> _update() async {
    List datas = await db.getTotalList();
    if (datas.length > 0) {
      //修改第一条数据
      User u = User.fromMap(datas[0]);
      u.name = "我被修改了";
      db.updateItem(u);
      _query();
    }
  }

//查询
  Future<Null> _query() async {
    _datas.clear();
    List datas = await db.getTotalList();
    if (datas.length > 0) {
      //数据库有数据
      datas.forEach((user) {
        User dataListBean = User.fromMap(user);
        _datas.add(dataListBean);
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("sqflite学习"),
        centerTitle: true,
        actions: <Widget>[
          new PopupMenuButton(
              onSelected: (String value) {
                switch (value) {
                  case "增加":
                    _add();
                    break;
                  case "删除":
                    _delete();
                    break;
                  case "修改":
                    _update();
                    break;
                  case "查询":
                    _query();
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    new PopupMenuItem(value: "增加", child: new Text("增加")),
                    new PopupMenuItem(value: "删除", child: new Text("删除")),
                    new PopupMenuItem(value: "修改", child: new Text("修改")),
                    new PopupMenuItem(value: "查询", child: new Text("查询")),
                  ])
        ],
      ),
      body: RefreshIndicator(
        displacement: 15,
        onRefresh: _refresh,
        child: ListView.separated(
            itemBuilder: _renderRow,
            physics: new AlwaysScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 0.5,
                color: Colors.black38,
              );
            },
            itemCount: _datas.length),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(5),
            child: Text("姓名：" + _datas[index].name)),
        Padding(
            padding: EdgeInsets.all(5),
            child: Text("年龄：" + _datas[index].age.toString())),
      ],
    );
  }
}

class User {
  String name;
  int age;
  int id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['age'] = age;
    map['id'] = id;
    return map;
  }

  static User fromMap(Map<String, dynamic> map) {
    User user = new User();
    user.name = map['name'];
    user.age = map['age'];
    user.id = map['id'];
    return user;
  }

  static List<User> fromMapList(dynamic mapList) {
    List<User> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  final String tableName = "table_user";
  final String columnId = "id";
  final String columnName = "name";
  final String columnAge = "age";
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'sqflite.db');
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  //创建数据库表
  void _onCreate(Database db, int version) async {
    await db.execute(
        "create table $tableName($columnId integer primary key,$columnName text not null ,$columnAge integer not null )");
    print("Table is created");
  }

//插入
  Future<int> saveItem(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", user.toMap());
    return res;
  }

  //查询
  Future<List> getTotalList() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName ");
    return result.toList();
  }

  //查询总数
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        "SELECT COUNT(*) FROM $tableName"
    ));
  }

//按照id查询
  Future<User> getItem(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE id = $id");
    if (result.length == 0) return null;
    return User.fromMap(result.first);
  }


  //清空数据
  Future<int> clear() async {
    var dbClient = await db;
    return await dbClient.delete(tableName);
  }


  //根据id删除
  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableName,
        where: "$columnId = ?", whereArgs: [id]);
  }

  //修改
  Future<int> updateItem(User user) async {
    var dbClient = await db;
    return await dbClient.update("$tableName", user.toMap(),
        where: "$columnId = ?", whereArgs: [user.id]);
  }

  //关闭
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}


// 作者：ngu2008
// 链接：https://juejin.im/post/5c9dbbaa5188250f4d3a0866
// 来源：掘金
// 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。