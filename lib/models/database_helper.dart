import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../constants.dart';
import 'contacts.dart';

class DatabaseHelper {
  Future<Database> init() async {
    final path = join(await getDatabasesPath(), Constants.databaseName);
    final db = await openDatabase(path, version: Constants.databaseVersion,
        onCreate: (Database db, int version) {
      return db.execute(''' CREATE TABLE contacts(
                            id INTEGER PRIMARY KEY, 
                            first TEXT,
                            last TEXT,
                            email TEXT,
                            birthDate TEXT,
                            phone TEXT,
                            pictureLink TEXT,
                            country TEXT,
                            state TEXT,
                            city TEXT,
                            streetName TEXT,
                            streetNumber INTEGER 
                          )''');
    });
    return db;
  }

  Future<void> insertContact(Contact contact, Database db) async {
    contact.id = await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contact>> getContact(Database db) async {
    List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (index) {
      return Contact.fromMap(maps[index]);
    });
  }

  Future<void> delete(int id, Database db) async {
    await db.delete('contacts', where: '${Constants.id} = ?', whereArgs: [id]);
  }

  Future<void> update(Contact contact, Database db) async {
    await db.update('contacts', contact.toMap(),
        where: '${Constants.id} = ?', whereArgs: [contact.id]);
  }

  Future<int?> size(Database db) async {
    var count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM contacts'));
    return count;
  }

  Future close(Database db) async => db.close();
}
