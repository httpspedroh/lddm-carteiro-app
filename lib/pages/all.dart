// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../assets/object.dart';
import '../assets/_functions.dart';

// ------------------------------------------------------------------------------------------------- //

// create a stateful widget with optional parameters from navigator
class AllObjects extends StatefulWidget {

	final bool? isArchived;
	final bool? isFavorited;
	final bool? isDelivered;

	const AllObjects({this.isArchived, this.isFavorited, this.isDelivered, Key? key}) : super(key: key);

	@override
	_AllObjectsState createState() => _AllObjectsState();
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

												// Create object
												final object = Object(

													name: controllerName.text,
													trackingCode: controllerTrackingCode.text,
													lastUpdate: DateTime.now(),
												);

												Future<int> result = pst.insertObject(object);

												result.then((insertedId) {

													if(insertedId != -1) {

														// Show snackbar
														ScaffoldMessenger.of(context).showSnackBar(

															const SnackBar(

																content: Text("Objeto adicionado com sucesso!",
																	style: TextStyle(color: Colors.white),
																),
																backgroundColor: Colors.green,
															)
														);

														// Refresh screen
														setState(() {});
													}
													else {

														// Show snackbar
														ScaffoldMessenger.of(context).showSnackBar(

															const SnackBar(

																content: Text("Erro ao adicionar objeto :(",
																	style: TextStyle(color: Colors.white),
																),
																backgroundColor: Colors.red,
															)
														);
													}

													// Close dialog	
													Navigator.of(context).pop();

												});
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
				title: Builder(
				builder: 
				
					(BuildContext context) {

						String title = 'Todos';
						
						if (widget.isArchived == true) { title = 'Arquivados'; }
						else if (widget.isFavorited == true) { title = 'Favoritos'; }
						else if (widget.isDelivered == true) { title = 'Entregues'; }

						return Text(title, style: const TextStyle(fontWeight: FontWeight.bold));
					},
				),

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
			body: FutureBuilder<List<Object>>(
				
				future: pst.getObjects(archived: widget.isArchived, favorited: widget.isFavorited, delivered: widget.isDelivered),
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

				onPressed: () => _showAlertDialog(context),
				child: const Icon(Icons.add),
			),

		);
  	}

	// ------------------------------------------------------------ //

	Widget _listView(AsyncSnapshot snapshot) {

		if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {

			return (snapshot.data!.length == 0 ? const Center(child: Text("Nenhum objeto encontrado 😢")) : 
			
				ListView.builder(

					itemCount: snapshot.data!.length,
					itemBuilder: (context, index) {

						return Dismissible(
							
							key: UniqueKey(),
							direction: DismissDirection.horizontal,
							
							background: Container(

								color: Colors.purple,
								alignment: Alignment.centerLeft,
								padding: const EdgeInsets.only(left: 25.0),
								child: widget.isArchived == true ? const Icon(Icons.unarchive) : const Icon(Icons.archive),
							),

							secondaryBackground: Container(
								
								color: Colors.red,
								alignment: Alignment.centerRight,
								padding: const EdgeInsets.only(right: 25.0),
								child: const Icon(Icons.delete),
							),

							onDismissed: (direction) {
								
								if (direction == DismissDirection.endToStart) {
								
									Object toDelete = snapshot.data![index];
									Future<int> result = pst.deleteObject(toDelete.id!);

									result.then((success) {

										if(success == 1) {

											ScaffoldMessenger.of(context).showSnackBar(

												SnackBar(

													backgroundColor: Colors.green,
													content: Text("\"${toDelete.name}\" excluído com sucesso!", 
														style: const TextStyle(color: Colors.white)
													),

													action: SnackBarAction(

														label: "DESFAZER",
														onPressed: () {

															pst.insertObject(toDelete);

															setState(() {});
														},
													),
												)
											);

											Navigator.pop(context);
										}
										else {

											ScaffoldMessenger.of(context).showSnackBar(
												
												const SnackBar(
													
													content: Text("Erro ao excluir objeto :(", 
														style: TextStyle(color: Colors.white)
													),

													backgroundColor: Colors.red,
												),
											);
										}
									});
								} 
								else if (direction == DismissDirection.startToEnd) {
								
									Object toArchive = snapshot.data![index];

									toArchive.archived = toArchive.archived == false ? true : false;

									Future<int> result = pst.updateObject(toArchive);

									result.then((success) {

										if(success == 1) {

											ScaffoldMessenger.of(context).showSnackBar(

												SnackBar(

													backgroundColor: Colors.green,
													content: Text(widget.isArchived == true ? "\"${toArchive.name}\" desarquivado com sucesso!" : "\"${toArchive.name}\" arquivado com sucesso!",
													
														style: const TextStyle(color: Colors.white)
													),

													action: SnackBarAction(

														label: "DESFAZER",
														onPressed: () {

															toArchive.archived = toArchive.archived == false ? true : false;

															pst.updateObject(toArchive);

															setState(() {});
														},
													),
												)
											);

											setState(() {});
										}
										else {

											ScaffoldMessenger.of(context).showSnackBar(
												
												SnackBar(
													
													content: Text(widget.isArchived == true ? "Erro ao desarquivar objeto :(" : "Erro ao arquivar objeto :(",
														style: const TextStyle(color: Colors.white)
													),

													backgroundColor: Colors.red,
												),
											);
										}
									});
								}
							},
							
							child: InkWell(

								onTap: () {

									Navigator.pushNamed(context, "/details", arguments: snapshot.data![index]);
								},

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
														size: 30 ,
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
																	Text(snapshot.data![index].name,
																	
																		overflow: TextOverflow.fade,
																		style: const TextStyle(
																			
																			fontSize: 15,
																			fontWeight: FontWeight.bold,
																			// fontWeight: index > 0 ? FontWeight.normal : FontWeight.bold,
																		),
																	),

																	
																	const Spacer(),

																	// Last update formatted with a function
																	Text(pst.formatDate(snapshot.data![index].lastUpdate),
													
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
