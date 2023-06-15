import 'package:flutter/material.dart';
import '../assets/_functions.dart';
import '../assets/object.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

// ------------------------------------------------------------------------------------------------- //

class Details extends StatefulWidget {

  	const Details({super.key});

  	@override
  	State<Details> createState() => _DetailsState();
}

// ------------------------------------------------------------------------------------------------- //

class _DetailsState extends State<Details> {

	final pst = CommonFunctions();

	// ----------------------------------------------------------------- //

  	@override
  	Widget build(BuildContext context) {

		// get obj in argument 0
		Object obj = ModalRoute.of(context)!.settings.arguments as Object;

		// ------------------------------------------------------------------- //

		return Scaffold(

			// ---------------------------------- //

			body: NestedScrollView(

        		headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {

          			return [

						SliverAppBar(

							backgroundColor: Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.secondary : null,
							actions: [

								IconButton(

									icon: Icon(obj.favorited == true ? Icons.favorite : Icons.favorite_border),
									onPressed: () {

										setState(() {

											obj.favorited = !obj.favorited!;
										});

										// update obj in database
										pst.updateObject(obj);
									},
								),

								const Padding(padding: EdgeInsets.only(right: 10)),
							],

							expandedHeight: 170.0,
							floating: false,
							pinned: true,
							
							flexibleSpace: FlexibleSpaceBar(

								centerTitle: true,
								background: Column(

									children: [

										Expanded(child: 
										
											Container(
												
												padding: const EdgeInsets.only(left: 70, top: 90, right: 70),
												child: Column(
														
													children: [
														
														Row(
															
															children: [

																Text(obj.trackingCode, style: const TextStyle(fontWeight: FontWeight.bold)),

																const Padding(padding: EdgeInsets.only(right: 5)),

																Image.asset('assets/images/brazil.png', height: 25, width: 25),
															],
														),

														Row(children: [

															Text(pst.formatDate(obj.lastUpdate, isDetails: true)),
														]),

														const Padding(padding: EdgeInsets.only(top: 10)),

														Row(children: [

															Text(obj.name,
																style: const TextStyle(fontSize: 30)
															),
														]),
													],
												)
											),
										),
									],
								),
							),
						),
          			];
        		},
				
				// ---------------------------------- //

				body: Builder(
					
					builder: (context) {

						List<Widget> widgets = [];

						// ---------------------------------- //

						var lastInfo = jsonDecode(obj.lastInfo!);
						
						for(int x = lastInfo.length - 1; x >= 0; x--) {

							var event = lastInfo[x];

							Color color;
							IconData icon;

							if(event['descricao'] == "Objeto entregue ao destinatário") {

								color = Colors.green;
								icon = Icons.home_rounded;
							}
							else if(event['descricao'] == "Objeto saiu para entrega ao destinatário") {

								color = Colors.purple;
								icon = Icons.delivery_dining_rounded;
							}
							else if(event['descricao'] == "Objeto postado") {

								color = Colors.orange;
								icon = Icons.approval_rounded;
							}
							else if(event['descricao'] == "Objeto recebido pelos Correios do Brasil" || event['destino'] == null) {

								color = Colors.yellow;
								icon = Icons.flag_rounded;
							}
							else {

								color = Colors.blue;
								icon = Icons.local_shipping_rounded;
							}

							// ---------------------------------- //

							widgets.add(Row(
					
								children: [
									
									Container(

										height: 90,
										width: 90,
										padding: const EdgeInsets.only(top: 17, bottom: 17),
										child: CircleAvatar(

											backgroundColor: color,
											child: Icon(icon,
												color: Colors.black,
												size: 25,
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
														
														children: [

															const Padding(padding: EdgeInsets.only(top: 15)),

															Text(event['descricao'],

																textAlign: TextAlign.center,
																style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
															),

															const Spacer(),

															Column(
															
																crossAxisAlignment: CrossAxisAlignment.end,

																children: [

																	Text(DateFormat('MMM dd, yyyy').format(DateTime.parse(event['data'])),

																		style: const TextStyle(fontSize: 10),
																	),

																	Text(DateFormat('kk:mm:ss').format(DateTime.parse(event['data'])),

																		style: const TextStyle(fontSize: 8),
																	),
																],
															)
														],
													),
													
													const Padding(padding: EdgeInsets.only(top: 12)),

													Row(
														
														children: [

															Builder(
																
																builder: (context) {

																	List<Widget> widgetsDetails = [];

																	// ----------------------------------- //

																	widgetsDetails.add(Row(
																
																		children: [

																			const Icon(Icons.location_on_rounded,
																				size: 15,
																			),

																			const Padding(padding: EdgeInsets.only(left: 5)),

																			Text(event["origem"],
																				
																				overflow: TextOverflow.fade,
																				style: const TextStyle(fontSize: 13),
																			),

																		],
																	));

																	if(event["destino"] != null) {

																		widgetsDetails.add(const Padding(padding: EdgeInsets.only(top: 5)));

																		widgetsDetails.add(Row(
																			
																			children: [

																				const Icon(Icons.local_shipping_rounded,
																					size: 15,
																				),

																				const Padding(padding: EdgeInsets.only(left: 5)),

																				Text(event["destino"],
																					
																					overflow: TextOverflow.fade,
																					style: const TextStyle(fontSize: 13),
																				),

																			],
																		));
																	}

																	// --------------------------- /

																	return Column(
																		
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: widgetsDetails
																	);
																}
															)

														],
													),
												], 
											),
										),
									),
								],
							));
						}

						// ---------------------------------- //

						return Column(children: widgets);
					}
				
				),
			
				// ---------------------------------- //

			),
		);
	}
}