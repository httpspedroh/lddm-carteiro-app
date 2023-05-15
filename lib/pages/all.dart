import 'package:flutter/material.dart';
import '../components/drawer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ------------------------------------------------------------------------------------------------- //

class AllObjects extends StatefulWidget {

  	const AllObjects({super.key});

  	@override
  	State<AllObjects> createState() => _AllObjectsState();
}

// ------------------------------------------------------------------------------------------------- //

class _AllObjectsState extends State<AllObjects> {

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

		print("aberto: " + db.isOpen.toString());
		return db;
	}

	_createObject(String name, String trackingCode) async {

		Database db = await _getDatabase();
		Map<String, dynamic> object = {

			"name": name,
			"tracking_code": trackingCode,
			"last_info": "{}",
			"last_update": DateTime.now().toString()
		};

		int id = await db.insert("objects", object);
		print("Saved: $id");
	}

	_listObjects() async {

		Database db = await _getDatabase();
		String sql = "SELECT * FROM objects";
		List objects = await db.rawQuery(sql);

		for(var object in objects) {

			print("id: " + object['id'].toString() +
				" name: " + object['name'] +
				" tracking_code: " + object['tracking_code'] +
				" last_info: " + object['last_info'] + 
				" last_update: " + object['last_update']);
		}
		return objects;
	}

	_deleteObject(String name) async {

		Database db = await _getDatabase();
		int deleted = await db.delete("objects", where: "name = ?", whereArgs: [name]);

		print("Deleted: $deleted");
	}

	_updateObject(int id, String name, String trackingCode) async {

		Database db = await _getDatabase();
		Map<String, dynamic> object = {

			"name": name,
			"tracking_code": trackingCode,
			"last_info": "{}",
			"last_update": DateTime.now().toString()
		};

		int updated = await db.update("objects", object, where: "id = ?", whereArgs: [id]);
		print("Updated: $updated");
	}

	_deleteAllObjects() async {

		Database db = await _getDatabase();
		int deleted = await db.delete("objects");
		print("Deleted: $deleted");
	}

	Future _showAlertDialog(BuildContext context) async {

		TextEditingController _controllerTrackingCode = TextEditingController();
		TextEditingController _controllerName = TextEditingController();

		return showDialog(

			barrierDismissible: false,
			context: context,
			builder: (BuildContext context) {

				return AlertDialog(

					contentPadding: EdgeInsets.zero,
					title: const Text("Adicionar objeto",
						style: TextStyle(fontSize: 15)
					),

					content: Container(
						
						padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 5),
						width: MediaQuery.of(context).size.width * 0.8,
						child: Column(
						
							mainAxisSize: MainAxisSize.min,
							children: [

								TextField(

									decoration: const InputDecoration(

										labelText: "Código de rastreio",
										helperText: "Ex: AB123456789BR",
										border: OutlineInputBorder(
											borderSide: BorderSide(
												color: Colors.white24,
												width: 1.0,
											),
										),
									),

									cursorColor: Colors.white24,
									controller: _controllerTrackingCode,
									maxLength: 13,
								),

								const SizedBox(height: 15),

								TextField(

									decoration: const InputDecoration(

										labelText: "Nome do objeto",
										border: OutlineInputBorder(
											borderSide: BorderSide(
												color: Colors.white24,
												width: 1.0,
											),
										),
									),

									cursorColor: Colors.white24,
									controller: _controllerName,
									maxLength: 30,
								),
							],
							
						),
					),

					actions: [

						// Make 2 buttons white space between them
						Padding(
							
							padding: const EdgeInsets.only(left: 10, right: 10),
							child: Row(

								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [

									// Button without background
									TextButton(

										child: const Padding(

											padding: EdgeInsets.only(top: 10, bottom: 10),
											child: Text("CANCELAR",
												style: TextStyle(
													color: Colors.red,
													fontSize: 13,
												),
											),
										),

										onPressed: () {
											Navigator.of(context).pop();
										}
									),

									// Make non-clickable button when text controllers are empty
									TextButton(

										child: const Padding(

											padding: EdgeInsets.only(top: 10, bottom: 10),
											child: Text("ADICIONAR",
												style: TextStyle(fontSize: 13),
											),
										),

										onPressed: () {
											Navigator.of(context).pop();
										}
									),
								],
							),
	
						)
					],
				);
			}
		);
	}

	// ------------------------------------------------------------------------------------------------- //

  	@override
  	Widget build(BuildContext context) {

		return Scaffold(

			// ---------------------------------- //

			appBar: AppBar(

				backgroundColor: Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.secondary : null,
				centerTitle: true,
				title: const Text("Todos", style: TextStyle(fontWeight: FontWeight.bold)),
				actions: const [

					Padding(

						padding: EdgeInsets.symmetric(horizontal: 16),
						child: Icon(Icons.search),
					),
				],
			),

			// ---------------------------------- //

			drawer: const NavDrawer(),

			// ---------------------------------- //

			// body: Column(

			// 	children: [

			// 		// ---------------------------------- //
					
			// 		Expanded(

			// 			child: ListView.builder(

			// 				itemCount: 3,
			// 				itemBuilder: (context, index) {

			// 					return InkWell(

			// 						onTap: () => Navigator.pushNamed(context, "/details"),
    		// 						child: Container(
									
			// 							color: index % 2 != 0 ? Colors.transparent : Colors.black12,
			// 							child: Row(
							
			// 								children: [
												
			// 									Container(

			// 										height: 90,
			// 										width: 90,
			// 										padding: const EdgeInsets.only(top: 17, bottom: 17),
			// 										child: const CircleAvatar(

			// 											backgroundColor: Color.fromARGB(255, 203, 100, 221),
			// 											child: Icon(Icons.delivery_dining_rounded,
			// 												color: Colors.black,
			// 												size: 30,
			// 											),
			// 										),
			// 									),
												

			// 									Expanded(
													
			// 										child: Container(
														
			// 											padding: const EdgeInsets.only(top: 15, bottom: 20, right: 15),
			// 											child: Column(

			// 												crossAxisAlignment: CrossAxisAlignment.stretch,
			// 												children: [
																
			// 													Row(
																	
			// 														children:  [

			// 															const Padding(padding: EdgeInsets.only(top: 15)),

			// 															Text("Switch Game",

			// 																textAlign: TextAlign.center,
			// 																style: TextStyle(

			// 																	fontSize: 15,
			// 																	fontWeight: index > 0 ? FontWeight.normal : FontWeight.bold,
			// 																),
			// 															),

			// 															const Spacer(),

			// 															Text("13 min atrás",

			// 																style: TextStyle(

			// 																	fontSize: 10,
			// 																	fontWeight: index > 0 ? FontWeight.normal : FontWeight.bold,
			// 																),
			// 															),
			// 														],
			// 													),
																
			// 													const Padding(padding: EdgeInsets.only(top: 12)),

			// 													Row(
																	
			// 														children: const [


			// 															Icon(Icons.arrow_right_alt_rounded,
			// 																size: 15,
			// 															),

			// 															Padding(padding: EdgeInsets.only(left: 5)),

			// 															Text("Saiu para entrega ao destinatário",
																			
			// 																overflow: TextOverflow.fade,
			// 																style: TextStyle(fontSize: 13),
			// 															),

			// 														],
			// 													),

			// 													const Padding(padding: EdgeInsets.only(top: 5)),

			// 													Row(
																	
			// 														children: const [

			// 															Icon(Icons.location_on_rounded,
			// 																size: 15,
			// 															),

			// 															Padding(padding: EdgeInsets.only(left: 5)),

			// 															Text("CDD PAMPULHA - BELO HORIZONTE/MG",
																			
			// 																overflow: TextOverflow.fade,
			// 																style: TextStyle(fontSize: 13),
			// 															),

			// 														],
			// 													),
			// 												], 
			// 											),
			// 										),
			// 									),
			// 								],
			// 							)
			// 						),
			// 					);
			// 				},
			// 			),
			// 		),

			// 		// ---------------------------------- //
			// 	],
			// ),
			
			// ---------------------------------- //

			floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
			floatingActionButton: FloatingActionButton(

				onPressed: () => _showAlertDialog(context),
				child: const Icon(Icons.add),
			),

		);
  	}
}
