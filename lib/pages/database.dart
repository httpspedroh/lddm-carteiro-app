import 'package:flutter/material.dart';
import '../components/drawer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ------------------------------------------------------------------------------------------------- //

class Database extends StatefulWidget {

  	const Database({super.key});

  	@override
  	State<Database> createState() => _DatabaseState();
}

// ------------------------------------------------------------------------------------------------- //

class _DatabaseState extends State<Database> {

	// ------------------------------------------------------------------------- //

	_getDatabase() async {
		
		final dbPath = await getDatabasesPath();
		final dbFile = join(dbPath, "postino.bd");

		var db = await openDatabase(

			dbFile,
			version: 1,
			onCreate: (db, recentVersion) {

				// Create a map with "id" (auto_increment), "user_id" (int), "name" (string), "tracking_code" (string), "last_info" (json), "last_update" (datetime)
				String sql = "CREATE TABLE objects (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, tracking_code VARCHAR, last_info TEXT, last_update DATETIME)";
				db.execute(sql);
			}
		);
		return db;
	}

	// ------------------------------------------------------------------------- //
	
  	@override
  	Widget build(BuildContext context) {

		// Return buttons "Connect", "Disconnect", "Create table", "Insert", "Update", "Delete"

		return Scaffold(

			appBar: AppBar(

				backgroundColor: Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.secondary : null,
				centerTitle: true,
				title: const Text("Database", style: TextStyle(fontWeight: FontWeight.bold)),
			),

			drawer: const NavDrawer(),

			body: Column(
				
				children: [

					TextButton(

						child: const Text("Connect"),
						onPressed: () async {

							var db = await _getDatabase();
							print(db);
						},
					),

					TextButton(

						child: const Text("Disconnect"),
						onPressed: () async {

							var db = await _getDatabase();
							await db.close();
							print(db);
						},
					),

					TextButton(

						child: const Text("Create table"),
						onPressed: () async {

							var db = await _getDatabase();
							print(db);
						},
					),
				],
			),

		);
	}
}