import 'package:flutter/material.dart';
import '../components/drawer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../assets/_constants.dart';

// ------------------------------------------------------------------------------------------------- //

class DbDebug extends StatefulWidget {

  	const DbDebug({super.key});

  	@override
  	State<DbDebug> createState() => _DbDebugState();
}

// ------------------------------------------------------------------------------------------------- //

class _DbDebugState extends State<DbDebug> {

	_getDatabase() async {
		
		final dbPath = await getDatabasesPath();
		final dbFile = join(dbPath, "postino.bd");

		var db = await openDatabase(

			dbFile,
			version: 1,
			onCreate: (db, recentVersion) {

				String sql = "CREATE TABLE objects (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, tracking_code VARCHAR, label INTEGER, last_info TEXT, last_update DATETIME)";

				db.execute(sql);
			}
		);
		return db;
	}

	// ------------------------------------------------------------ //

	_createObject(String name, String trackingCode) async {

		Database db = await _getDatabase();
		Map<String, dynamic> object = {

			"name": name,
			"tracking_code": trackingCode,
			"label": Constants.statusAll,
			"last_info": "{}",
			"last_update": DateTime.now().toString()
		};

		db.insert("objects", object);
	}

	// ------------------------------------------------------------ //

	_deleteObject(int id) async {

		Database db = await _getDatabase();
		
		db.delete(

			"objects",
			where: "id = ?",
			whereArgs: [id]
		);
	}

	// ------------------------------------------------------------ //

	_updateObject(int id, String trackingCode, int label, String name) async {

		Database db = await _getDatabase();
		Map<String, dynamic> object = {

			"name": name,
			"tracking_code": trackingCode,
			"label": label,
			"last_info": "{}",
			"last_update": DateTime.now().toString()
		};

		db.update(

			"objects",
			object,
			where: "id = ?",
			whereArgs: [id]
		);
	}

	// ------------------------------------------------------------ //

	Future<List<Map<String, dynamic>>> _getAllObjects() async {

		Database db = await _getDatabase();
		String sql = "SELECT * FROM objects";
		List<Map<String, dynamic>> objects = await db.rawQuery(sql);

		return objects;
	}

	// ------------------------------------------------------------ //

	String _formatDate(String date) {

		DateTime now = DateTime.now();
		DateTime lastUpdate = DateTime.parse(date);

		// If the last update was > 7 days ago, return the date in the format "Feb 25, 2022"
		if(now.difference(lastUpdate).inDays > 7) {

			return "${lastUpdate.day.toString().padLeft(2, '0')}/${lastUpdate.month.toString().padLeft(2, '0')}/${lastUpdate.year.toString()}";
		}

		// If the last update was > 1 day ago, return the date in the format "2 days ago"
		else if(now.difference(lastUpdate).inDays >= 1) {

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

	// ------------------------------------------------------------ //

	Future _showAlertDialog(BuildContext context, int id, String name, String trackingCode, int label) async {

		TextEditingController controllerTrackingCode = TextEditingController();
		TextEditingController controllerName = TextEditingController();

		// if id != 0, it means that the user wants to edit an object, than fill the text fields with the object's data
		if(id != 0) {

			controllerTrackingCode.text = trackingCode;
			controllerName.text = name;
		}

		return showDialog(

			barrierDismissible: false,
			context: context,
			builder: (BuildContext context) {

				return AlertDialog(

					contentPadding: EdgeInsets.zero,
					title: Text((id == 0 ? "Adicionar objeto" : "Editar objeto"),
						style: const TextStyle(fontSize: 15)
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
									controller: controllerTrackingCode,
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
									controller: controllerName,
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

										child: Padding(

											padding: const EdgeInsets.only(top: 10, bottom: 10),
											child: Text((id == 0 ? "ADICIONAR" : "EDITAR"),
												style: const TextStyle(fontSize: 13),
											),
										),

										onPressed: () {
											
											if(controllerTrackingCode.text.isNotEmpty && controllerName.text.isNotEmpty) {

												if(id == 0) { _createObject(controllerTrackingCode.text, controllerName.text); }
												else { _updateObject(id, controllerTrackingCode.text, label, controllerName.text); }
												
												Navigator.of(context).pop();

												// Refresh screen
												setState(() {});
											}
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

	// ------------------------------------------------------------------------------------------------------------------------ //

  	@override
  	Widget build(BuildContext context) {

		return Scaffold(

			// ---------------------------------- //

			appBar: AppBar(

				backgroundColor: Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.secondary : null,
				centerTitle: true,
				title: const Text("Database Debug", style: TextStyle(fontWeight: FontWeight.bold)),
			),

			// ---------------------------------- //

			drawer: const NavDrawer(),

			// ---------------------------------- //

			body: FutureBuilder<List<Map<String, dynamic>>>(
				
				future: _getAllObjects(),
				builder: (context, snapshot) {
					
					return RefreshIndicator(

						onRefresh: _pullRefresh,
						child: _listView(snapshot),
					);
				},
			),

			// ---------------------------------- //

			floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
			floatingActionButton: FloatingActionButton(

				onPressed: () => _showAlertDialog(context, 0, "", "", 0),
				child: const Icon(Icons.add),
			),
    	);
	}

	// ------------------------------------------------------------ //

	Widget _listView(AsyncSnapshot snapshot) {

		if(snapshot.hasData) {

			return (snapshot.data!.length == 0 ? const Center(child: Text("Nenhum objeto encontrado 😢")) : 
			
				ListView.builder(

				itemCount: snapshot.data!.length,
				itemBuilder: (context, index) {

					return InkWell(

						child: Container(
						
							color: index % 2 != 0 ? Colors.transparent : Colors.black12,
							child: Row(
				
								children: [
									
									Container(

										height: 90,
										width: 90,
										padding: const EdgeInsets.only(top: 17, bottom: 17),
										child: const CircleAvatar(

											backgroundColor: Color.fromARGB(255, 203, 100, 221),
											child: Icon(Icons.delivery_dining_rounded,
												color: Colors.black,
												size: 30,
											),
										),
									),
									

									Expanded(
										
										child: Container(
											
											padding: const EdgeInsets.only(top: 15, bottom: 20, right: 15),
											child: Column(

												crossAxisAlignment: CrossAxisAlignment.stretch,
												children: [
													
													Row(
														
														children:  [

															const Padding(padding: EdgeInsets.only(top: 15)),

															// Name
															Text(snapshot.data![index]["name"],
																
																overflow: TextOverflow.fade,
																style: const TextStyle(
																	
																	fontSize: 15,
																	fontWeight: FontWeight.normal,
																),
															),

															
															const Spacer(),

															// Last update formatted with a function
															Text(_formatDate(snapshot.data![index]["last_update"] as String),
											
																overflow: TextOverflow.fade,
																style: const TextStyle(
																	
																	fontSize: 10,
																	fontWeight: FontWeight.normal,
																),
															),
														],
													),
													
													const Padding(padding: EdgeInsets.only(top: 12)),

													Row(

														children: [

															Column(

																crossAxisAlignment: CrossAxisAlignment.start,
																children: [

																	Text("Código: ${snapshot.data![index]["tracking_code"]}",
																		
																		overflow: TextOverflow.fade,
																		style: const TextStyle(
																			
																			fontSize: 12,
																			fontWeight: FontWeight.normal,
																		),
																	),

																	Text("ID: ${snapshot.data![index]["id"]}",
																		
																		overflow: TextOverflow.fade,
																		style: const TextStyle(
																			
																			fontSize: 12,
																			fontWeight: FontWeight.normal,
																		),
																	),
																],
															),

															const Spacer(),

															IconButton(

																onPressed: () {

																	_deleteObject(snapshot.data![index]["id"] as int);
																	setState(() {});
																},
																
																icon: const Icon(Icons.delete_forever_rounded),
															),

															IconButton(

																onPressed: () => _showAlertDialog(context, snapshot.data![index]["id"] as int, snapshot.data![index]["name"] as String, snapshot.data![index]["tracking_code"] as String, snapshot.data![index]["label"] as int),
																icon: const Icon(Icons.edit_rounded),
															),
														],
													)
												], 
											),
										),
									),
								],
							)
						),
					);
				},
			));
		}
		else {

			return const Center(child: CircularProgressIndicator());
		}
	}

	// ------------------------------------------------------------ //

	Future<void> _pullRefresh() async {

		await Future.delayed(const Duration(seconds: 1));

		setState(() {});
	}
}