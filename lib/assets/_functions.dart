import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'object.dart';

// ------------------------------------------------------------------------------------------------- //

class CommonFunctions {

	Future<Database> getDatabase() async {

		final dbPath = await getDatabasesPath();
		final dbFile = join(dbPath, "postino.bd");

		var db = await openDatabase(

			dbFile,
			version: 1,
			onCreate: (db, recentVersion) {

				String sql = "CREATE TABLE IF NOT EXISTS objects ("
					"id INTEGER PRIMARY KEY AUTOINCREMENT,"
					"archived INTEGER CHECK (archived IN (0, 1)) DEFAULT 0,"
					"favorited INTEGER CHECK (favorited IN (0, 1)) DEFAULT 0,"
					"delivered INTEGER CHECK (delivered IN (0, 1)) DEFAULT 0,"
					"name VARCHAR(30) NOT NULL DEFAULT '(Sem nome)',"
					"tracking_code VARCHAR(13) NOT NULL DEFAULT '(Sem código)',"
					"last_info TEXT DEFAULT NULL,"
					"last_update DATETIME DEFAULT NULL" 
				")";

				db.execute(sql);
			},
		);
		return db;
	}

	// ------------------------------------------------------------- //

	Future<int> insertObject(Object object) async {

		final Database db = await getDatabase();

		try {

			return await db.insert(

				"objects",
				object.toMap(),
				conflictAlgorithm: ConflictAlgorithm.replace,
			);
		} 
		catch(e) { return -1; }
	}

	// ------------------------------------------------------------- //

	Future<int> deleteObject(int id) async {

		final Database db = await getDatabase();
		
		return await db.delete(

			"objects",
			where: "id = ?",
			whereArgs: [id],
		);
	}

	// ------------------------------------------------------------- //

	Future<int> updateObject(Object object) async {

		final Database db = await getDatabase();

		return await db.update(

			"objects",
			object.toMap(),
			where: "id = ?",
			whereArgs: [object.id],
		);
	}

	// ------------------------------------------------------------ //


	// get objects with dynamic optional where
	Future<List<Object>> getObjects({bool? archived, bool? favorited, bool? delivered}) async {

		final Database db = await getDatabase();

		String where = "";

		if(archived != null) {

			where += "archived = ${archived ? 1 : 0}";
		}

		if(favorited != null) {

			if(archived != null) where += " AND ";

			where += "favorited = ${favorited ? 1 : 0}";
		}

		if(delivered != null) {

			if(archived != null || favorited != null) where += " AND ";

			where += "delivered = ${delivered ? 1 : 0}";
		}

		List<Map<String, dynamic>> maps = await db.query(

			"objects",
			where: where == "" ? null : where,
			orderBy: "last_update DESC",
		);

		return List.generate(maps.length, (index) {

			return Object(

				id: maps[index]["id"],
				archived: maps[index]["archived"] == 1 ? true : false,
				favorited: maps[index]["favorited"] == 1 ? true : false,
				delivered: maps[index]["delivered"] == 1 ? true : false,
				name: maps[index]["name"],
				trackingCode: maps[index]["tracking_code"],
				lastInfo: maps[index]["last_info"],
				lastUpdate: DateTime.parse(maps[index]["last_update"]),
			);
		});
	}

	// ------------------------------------------------------------ //

	String formatDate(DateTime lastUpdate, {bool? isDetails}) {

		DateTime now = DateTime.now();

		if(isDetails == true) {

			// Return "HOJE", "ONTEM" or "X DIAS ATRÁS"
			if(now.difference(lastUpdate).inDays == 0) { return "POSTADO HOJE"; }
			else if(now.difference(lastUpdate).inDays == 1) { return "POSTADO ONTEM"; }
			else { return "POSTADO HÁ ${now.difference(lastUpdate).inDays} DIAS ATRÁS"; }
		}
		else {

			// If the last update was > 7 days ago, return the date in the format "Feb 25, 2022"
			if(now.difference(lastUpdate).inDays > 7) {

				return "${lastUpdate.day.toString().padLeft(2, '0')}/${lastUpdate.month.toString().padLeft(2, '0')}/${lastUpdate.year.toString()}";
			}

			// If the last update was == 1 day ago, return the date in the format "Yesterday"
			else if(now.difference(lastUpdate).inDays == 1) {

				return "Ontem";
			}

			// If the last update was > 1 day ago, return the date in the format "2 days ago"
			else if(now.difference(lastUpdate).inDays > 1) {

				return "${now.difference(lastUpdate).inDays} dias atrás";
			}

			// If the last update was > 1 hour ago, return the date in the format "2h ago"
			else if(now.difference(lastUpdate).inHours >= 1) {

				return "${now.difference(lastUpdate).inHours}h atrás";
			}

			// If the last update was > 1 minute ago, return the date in the format "2 min ago"
			else if(now.difference(lastUpdate).inMinutes >= 1) {

				return "${now.difference(lastUpdate).inMinutes} min atrás";
			}

			// If the last update was > 1 second ago, return the date in the format "2 sec ago"
			else if(now.difference(lastUpdate).inSeconds > 1) {

				return "${now.difference(lastUpdate).inSeconds} seg atrás";
			}
		}
		return "1 seg atrás";
	}
}