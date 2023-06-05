import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ------------------------------------------------------------------------------------------------- //

class CommonFunctions {

	Future<Database> getDatabase() async {

		final dbPath = await getDatabasesPath();
		final dbFile = join(dbPath, "postino.bd");

		var db = await openDatabase(

			dbFile,
			version: 1,
			onCreate: (db, recentVersion) {

				String sql = "CREATE TABLE objects (id INTEGER PRIMARY KEY AUTOINCREMENT, folder INTEGER, name VARCHAR, tracking_code VARCHAR, last_info TEXT, last_update DATETIME)";

				db.execute(sql);
			},
		);
		return db;
	}

	// ------------------------------------------------------------- //

	Future<int> insertObject(Map<String, dynamic> object) async {

		final Database db = await getDatabase();

		return await db.insert("objects", object);
	}

	// ------------------------------------------------------------ //

	Future<List<Map<String, dynamic>>> getObjects(int folder) async {

		final Database db = await getDatabase();

		return await db.query(

			"objects",
			where: "folder = ?",
			whereArgs: [folder],
			orderBy: "last_update DESC",
		);
	}

	// ------------------------------------------------------------ //

	String formatDate(String date) {

		DateTime now = DateTime.now();
		DateTime lastUpdate = DateTime.parse(date);

		// If the last update was > 7 days ago, return the date in the format "Feb 25, 2022"
		if(now.difference(lastUpdate).inDays > 7) {

			return "${lastUpdate.day.toString().padLeft(2, '0')}/${lastUpdate.month.toString().padLeft(2, '0')}/${lastUpdate.year.toString()}";
		}

		// If the last update was == 1 day ago, return the date in the format "Yesterday"
		else if(now.difference(lastUpdate).inDays > 1) {

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
		return "1 seg atrás";
	}
}