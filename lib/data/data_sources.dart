import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDBClass {
  late Database dbInstance;

  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'notes.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE NotesData ( id INTEGER PRIMARY KEY , meeting_id INT, user_id INT,string TEXT)",
        );
      },
    );

    return dbInstance;
  }

  Future<void> createNote(
      {required String note,
      String? id,
      required int user_id,
      required int meeting_id}) async {
    int result = 0;

    var map = new Map<String, dynamic>();
    map = {'meeting_id': meeting_id, 'user_id': user_id, 'string': '$note'};

    final Database dbInstance = await initializedDB();

    final tables =
        await dbInstance.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');

    final id = await dbInstance.insert('NotesData', map,
        conflictAlgorithm: ConflictAlgorithm.replace);

    // for (var i = 0; i < tables.length; i++) {
    print(id);
    // }
  }

  Future<String> getNote(user_id, meeting_id) async {
    final Database dbInstance = await initializedDB();
    var note = await dbInstance.rawQuery(
        'SELECT * FROM NotesData WHERE user_id=? and meeting_id=?',
        ['$user_id', '$meeting_id']);

    var data = note[0]['string'];

    print(data);
    return data.toString();
  }
}
