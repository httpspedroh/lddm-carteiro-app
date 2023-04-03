import 'package:flutter/material.dart';
import '../components/drawer.dart';

// ------------------------------------------------------------------------------------------------- //

class AllObjects extends StatefulWidget {

  	const AllObjects({super.key});

  	@override
  	State<AllObjects> createState() => _AllObjectsState();
}

// ------------------------------------------------------------------------------------------------- //

class _AllObjectsState extends State<AllObjects> {

  	// ------------------------------------------------------------ //

  	@override
  	Widget build(BuildContext context) {

		return Scaffold(

			// ---------------------------------- //

			appBar: AppBar(

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

			body: Column(

				children: [

					// ---------------------------------- //
					
					Expanded(

						child: ListView.builder(

							itemCount: 3,
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

																		Text("Switch Game",

																			textAlign: TextAlign.center,
																			style: TextStyle(

																				fontSize: 15,
																				fontWeight: index > 0 ? FontWeight.normal : FontWeight.bold,
																			),
																		),

																		const Spacer(),

																		Text("13 min atrás",

																			style: TextStyle(

																				fontSize: 10,
																				fontWeight: index > 0 ? FontWeight.normal : FontWeight.bold,
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
						),
					),

					// ---------------------------------- //
				],
			),
			
			// ---------------------------------- //

			floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
			floatingActionButton: FloatingActionButton(

				onPressed: () {},
				child: const Icon(Icons.add),
			),

		);
  	}
}
