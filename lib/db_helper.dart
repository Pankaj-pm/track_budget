/*

CREATE TABLE "track_budget" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT,
	"category"	INTEGER NOT NULL,
	"type"	INTEGER NOT NULL,
	"amount"	REAL NOT NULL,
	"date"	TEXT NOT NULL,
	"user_id"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);



// get all data
`SELECT * FROM `student`;

get single record
SELECT * FROM `student` WHERE email==harsh@gmail.com


add data to table
INSERT INTO `student` (`name`,...) VALUES ('abc',..)
INSERT INTO "track_budget"("id","name","category","type","amount","date","user_id") VALUES (1,NULL,0,0,'','',0);

update data to table
UPDATE `student` SET `name`='xyz',` WHERE 1
UPDATE "track_budget" SET "date"="10-5-2025" WHERE "id"='1'


delete or remove record from table
DELETE FROM `student` WHERE mark<30


* */

import 'package:budget_tracker_app/home/budget_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._();

  DbHelper._();

  final String tableCategory = "category";

  Database? _db;

  void createDatabase() async {
    var databasesPath = await getDatabasesPath();
    _db = await openDatabase(
      "$databasesPath/budget.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE "track_budget" (
            "id"	INTEGER NOT NULL UNIQUE,
            "name"	TEXT,
            "category"	TEXT NOT NULL,
            "type"	INTEGER NOT NULL,
            "amount"	REAL NOT NULL,
            "date"	TEXT NOT NULL,
            "user_id"	INTEGER NOT NULL,
            PRIMARY KEY("id" AUTOINCREMENT)
        )''');

        await db.execute('''
            CREATE TABLE "$tableCategory" (
            "id"	INTEGER NOT NULL UNIQUE,
            "category_name"	TEXT NOT NULL,
            "category_type"	INTEGER NOT NULL,
            PRIMARY KEY("id" AUTOINCREMENT)
        )''');
      },
    );
  }

  Future addRecord(BudgetModel model) async {
    if (_db != null) {
      int res = await _db!.insert("track_budget", model.toJson());
    } else {
      print("Database is null");
    }
  }

  Future addCategory(String name, int type) async{
    if (_db != null) {
      await _db!.insert(tableCategory, {
        "category_name": name,
        "category_type": type,
      });
    } else {
      print("Database is null");
    }
  }

  Future<List<Map<String, Object?>>>  getCategory() async {
    if (_db != null) {
      List<Map<String, Object?>> category = await _db!.query(tableCategory);
      print("category ${category}");
      return category;

    } else {
      print("Database is null");
    }
    return [];
  }

  Future<List<Map<String, Object?>>>  getBudget() async {
    if (_db != null) {
      List<Map<String, Object?>> budgetList = await _db!.query("track_budget");
      print("category ${budgetList}");
      return budgetList;

    } else {
      print("Database is null");
    }
    return [];
  }
}
