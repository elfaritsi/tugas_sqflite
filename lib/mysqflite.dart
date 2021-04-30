import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tugas_sqflite_daeng_6sia4/karyawan.dart';

class MySqflite {
  static final _databaseName = "MyDatabase.db";
  static final _databaseV1 = 1;
  static final tableName = 'karyawan';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnPosition = 'position';

  MySqflite._privateConstructor();

  static final MySqflite instance = MySqflite._privateConstructor();
  static Database _database;

  _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);

    return await openDatabase(path, version: _databaseV1,
      onCreate: (db, version) async {
      var batch = db.batch();
      _onCreateTableKaryawan(batch);

      await batch.commit();
    });
  }

  void _onCreateTableKaryawan(Batch batch) async {
    batch.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT,
            $columnPosition TEXT
          )
          ''');
  }
       

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
      return _database;
    }
  }

  ///TABLE KARYAWAN
  Future<int> insertKaryawan(Karyawan karyawan) async {
    var row = {
      columnId: karyawan.id,
      columnName: karyawan.name,
      columnPosition: karyawan.position,
    };

    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Karyawan>> getKaryawan() async {
    Database db = await instance.database;
    var allData = await db.rawQuery("SELECT * FROM $tableName ORDER BY $columnName ASC");

    List<Karyawan> result = [];

    for (var data in allData) {
      result.add(Karyawan(
          id: int.tryParse(data[columnId].toString()),
          name: data[columnName],
          position: data[columnPosition],
          ));
    }
    return result;
  }

}
