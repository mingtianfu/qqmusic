import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Song {
  String name;
  num id;
  num arId;
  String picUrl;
  int orders;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['id'] = id;
    map['arId'] = arId;
    map['picUrl'] = picUrl;
    map['orders'] = orders;
    return map;
  }

  static Song fromMap(Map<String, dynamic> map) {
    Song song = new Song();
    song.name = map['name'];
    song.id = map['id'];
    song.arId = map['arId'];
    song.picUrl = map['picUrl'];
    song.orders = map['orders'];
    return song;
  }

  static List<Song> fromMapList(dynamic mapList) {
    List<Song> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class SongListHelper {
  static final SongListHelper _instance = SongListHelper.internal();
  factory SongListHelper() => _instance;
  final String tableName = "table_song_list";
  final String columnId = "id";
  final String columnName = "name";
  final String columnArId = "arId";
  final String columnPicUrl = "picUrl";
  final String columnOrders = "orders";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  SongListHelper.internal();

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'song_list.db');
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  //创建数据库表
  void _onCreate(Database db, int version) async {
    await db.execute(
        '''create table $tableName(
          $columnId integer primary key,
          $columnName text not null,
          $columnArId integer not null,
          $columnPicUrl text not null,
          $columnOrders integer not null
          )''');
    print("Table is created");
  }

//插入
  Future<int> saveItem(Song item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", item.toMap());
    return res;
  }

  //查询
  Future<List> getTotalList() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName order by $columnOrders asc");
    return result.toList();
  }

  // //查询总数
  // Future<int> getCount() async {
  //   var dbClient = await db;
  //   return Sqflite.firstIntValue(await dbClient.rawQuery(
  //       "SELECT COUNT(*) FROM $tableName"
  //   ));
  // }

//按照id查询
  // Future<TrackItem> getItem(int id) async {
  //   var dbClient = await db;
  //   var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE id = $id");
  //   print(result);
  //   if (result.length == 0) return null;
  //   // return TrackItem.fromMap(result.first);
  // }


  // 清空数据
  Future<int> clear() async {
    var dbClient = await db;
    return await dbClient.delete(tableName);
  }


  // //根据id删除
  // Future<int> deleteItem(int id) async {
  //   var dbClient = await db;
  //   return await dbClient.delete(tableName,
  //       where: "$columnId = ?", whereArgs: [id]);
  // }

  // //修改
  // Future<int> updateItem(TrackItem user) async {
  //   var dbClient = await db;
  //   return await dbClient.update("$tableName", user.toMap(),
  //       where: "$columnId = ?", whereArgs: [user.id]);
  // }

  //关闭
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}