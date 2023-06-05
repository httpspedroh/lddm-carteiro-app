import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../assets/_constants.dart';
import '../assets/_functions.dart';

// ------------------------------------------------------------------------------------------------- //

class AllObjects extends StatefulWidget {

  	const AllObjects({super.key});

  	@override
  	State<AllObjects> createState() => _AllObjectsState();
}

// ------------------------------------------------------------------------------------------------- //

class _AllObjectsState extends State<AllObjects> {

	final pst = CommonFunctions();

	// ----------------------------------------------------------------- //

	Future _showAlertDialog(BuildContext context) async {

		TextEditingController controllerTrackingCode = TextEditingController();
		TextEditingController controllerName = TextEditingController();

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

										child: const Padding(

											padding: EdgeInsets.only(top: 10, bottom: 10),
											child: Text("ADICIONAR",
												style: TextStyle(fontSize: 13),
											),
										),

										onPressed: () {
											
											if(controllerTrackingCode.text.isNotEmpty && controllerName.text.isNotEmpty) {

												Map<String, dynamic> object = {

													"name": controllerName.text,
													"trackingCode": controllerTrackingCode.text,
													"lastUpdate": DateTime.now().toString(),
												};

												pst.insertObject(object);

												// ----------------------------- //

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

	// ----------------------------------------------------------------- //

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

			// Create body with ListView.builder using data from database
			body: FutureBuilder<List<Map<String, dynamic>>>(
				
				future: pst.getObjects(Constants.folderAll),
				builder: (context, snapshot) {
					
					return RefreshIndicator(

						onRefresh: _pullRefresh,
						child: _listView(snapshot),
					);
				},
			),

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

	// ------------------------------------------------------------ //

	Widget _listView(AsyncSnapshot snapshot) {

		if(snapshot.hasData) {

			return (snapshot.data!.length == 0 ? const Center(child: Text("Nenhum objeto encontrado 😢")) : 
			
				ListView.builder(

					itemCount: snapshot.data!.length,
					itemBuilder: (context, index) {

						return InkWell(

							onTap: () => Navigator.pushNamed(context, "/details"),
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
																		// fontWeight: index > 0 ? FontWeight.normal : FontWeight.bold,
																	),
																),

																
																const Spacer(),

																// Last update formatted with a function
																Text(pst.formatDate(snapshot.data![index]["last_update"] as String),
												
																	overflow: TextOverflow.fade,
																	style: const TextStyle(
																		
																		fontSize: 10,
																		fontWeight: FontWeight.normal,
																		// fontWeight: index > 0 ? FontWeight.normal : FontWeight.bold,
																	),
																),
															],
														),
														
														const Padding(padding: EdgeInsets.only(top: 12)),

														Row(
															
															children: const [


																Icon(Icons.arrow_right_alt_rounded,
																	size: 15,
																),

																Padding(padding: EdgeInsets.only(left: 5)),

																Text("Saiu para entrega ao destinatário",
																	
																	overflow: TextOverflow.fade,
																	style: TextStyle(fontSize: 13),
																),

															],
														),

														const Padding(padding: EdgeInsets.only(top: 5)),

														Row(
															
															children: const [

																Icon(Icons.location_on_rounded,
																	size: 15,
																),

																Padding(padding: EdgeInsets.only(left: 5)),

																Text("CDD PAMPULHA - BELO HORIZONTE/MG",
																	
																	overflow: TextOverflow.fade,
																	style: TextStyle(fontSize: 13),
																),

															],
														),
													], 
												),
											),
										),
									],
								)
							),
						);
					},
				)
			);
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
