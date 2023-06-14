import 'package:flutter/material.dart';
import '../assets/_functions.dart';
import '../assets/object.dart';

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
												
												padding: const EdgeInsets.only(left: 70, top: 70, right: 70),
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
					
				body: Column(

					children: [
					
						// Item 1
						Row(
				
							children: [
								
								Container(

									height: 90,
									width: 90,
									padding: const EdgeInsets.only(top: 17, bottom: 17),
									child: const CircleAvatar(

										backgroundColor: Color.fromARGB(255, 203, 100, 221),
										child: Icon(Icons.delivery_dining_rounded,
											color: Colors.black,
											size: 25,
										),
									),
								),
								
								Expanded(
									
									child: Container(
										
										padding: const EdgeInsets.only(top: 15, bottom: 20, right: 15),
										child: const Column(

											crossAxisAlignment: CrossAxisAlignment.stretch,
											children: [
												
												Row(
													
													children: [

														Padding(padding: EdgeInsets.only(top: 15)),

														Text("Saiu para entrega ao destinatário",

															textAlign: TextAlign.center,
															style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
														),

														Spacer(),

														Text("13 min atrás",

															style: TextStyle(fontSize: 10),
														),
													],
												),
												
												Padding(padding: EdgeInsets.only(top: 12)),

												Row(
													
													children: [

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
						),
	
						// ---------------------------------- //

						// Item 2
						Row(
				
							children: [
								
								Container(

									height: 90,
									width: 90,
									padding: const EdgeInsets.only(top: 17, bottom: 17),
									child: const CircleAvatar(

										backgroundColor: Colors.blue,
										child: Icon(Icons.local_shipping_rounded,
											color: Colors.black,
											size: 25,
										),
									),
								),
								

								Expanded(
									
									child: Container(
										
										padding: const EdgeInsets.only(top: 15, bottom: 20, right: 15),
										child: const Column(

											crossAxisAlignment: CrossAxisAlignment.stretch,
											children: [
												
												Row(
													
													children: [

														Padding(padding: EdgeInsets.only(top: 15)),

														Text("Em trânsito",

															textAlign: TextAlign.center,
															style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
														),

														Spacer(),

														Column(
															
															crossAxisAlignment: CrossAxisAlignment.end,

															children: [

																Text("Fev 28, 2022",

																	style: TextStyle(fontSize: 10),
																),

																Text("15:34:12",

																	style: TextStyle(fontSize: 8),
																),
															],
														)
													],
												),
												
												Padding(padding: EdgeInsets.only(top: 12)),

												Row(
																
													children: [

														Icon(Icons.arrow_right_alt_rounded,
															size: 15,
														),

														Padding(padding: EdgeInsets.only(left: 5)),

														Text("Unidade de Distribuição - BELO HORIZONTE/MG",
															
															overflow: TextOverflow.fade,
															style: TextStyle(fontSize: 13),
														),
													],
												),

												Padding(padding: EdgeInsets.only(top: 5)),

												Row(
													
													children: [

														Icon(Icons.location_on_rounded,
															size: 15,
														),

														Padding(padding: EdgeInsets.only(left: 5)),

														Text("Unidade de Tratamento - BELO HORIZONTE/MG",
															
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
						),

						// ---------------------------------- //

						// Item 3
						Row(
				
							children: [
								
								Container(

									height: 90,
									width: 90,
									padding: const EdgeInsets.only(top: 17, bottom: 17),
									child: const CircleAvatar(

										backgroundColor: Colors.blue,
										child: Icon(Icons.local_shipping_rounded,
											color: Colors.black,
											size: 25,
										),
									),
								),
								

								Expanded(
									
									child: Container(
										
										padding: const EdgeInsets.only(top: 15, bottom: 20, right: 15),
										child: const Column(

											crossAxisAlignment: CrossAxisAlignment.stretch,
											children: [
												
												Row(
													
													children: [

														Padding(padding: EdgeInsets.only(top: 15)),

														Text("Em trânsito",

															textAlign: TextAlign.center,
															style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
														),

														Spacer(),

														Column(
															
															crossAxisAlignment: CrossAxisAlignment.end,

															children: [

																Text("Fev 25, 2022",

																	style: TextStyle(fontSize: 10),
																),

																Text("13:12:53",

																	style: TextStyle(fontSize: 8),
																),
															],
														)
													],
												),
												
												Padding(padding: EdgeInsets.only(top: 12)),

												Row(
																
													children: [

														Icon(Icons.arrow_right_alt_rounded,
															size: 15,
														),

														Padding(padding: EdgeInsets.only(left: 5)),

														Text("Unidade de Tratamento - BELO HORIZONTE/MG",
															
															overflow: TextOverflow.fade,
															style: TextStyle(fontSize: 13),
														),
													],
												),

												Padding(padding: EdgeInsets.only(top: 5)),

												Row(
													
													children: [

														Icon(Icons.location_on_rounded,
															size: 15,
														),

														Padding(padding: EdgeInsets.only(left: 5)),

														Text("Unidade de Tratamento - SAO PAULO/SP",
															
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
						),

						// ---------------------------------- //

						// Item 4
						Row(
				
							children: [
								
								Container(

									height: 90,
									width: 90,
									padding: const EdgeInsets.only(top: 17, bottom: 17),
									child: CircleAvatar(

										backgroundColor: Colors.orange,
										child: Image.asset("assets/images/trolley.png",
											color: Colors.black,
											height: 25,
											width: 25,
										),
									),
								),
								
								Expanded(
									
									child: Container(
										
										padding: const EdgeInsets.only(top: 15, bottom: 20, right: 15),
										child: const Column(

											crossAxisAlignment: CrossAxisAlignment.stretch,
											children: [
												
												Row(
													
													children: [

														Padding(padding: EdgeInsets.only(top: 15)),

														Text("Objeto postado",

															textAlign: TextAlign.center,
															style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
														),

														Spacer(),

														Column(
															
															crossAxisAlignment: CrossAxisAlignment.end,

															children: [

																Text("Fev 25, 2022",

																	style: TextStyle(fontSize: 10),
																),

																Text("11:08:06",

																	style: TextStyle(fontSize: 8),
																),
															],
														)
													],
												),
												
												Padding(padding: EdgeInsets.only(top: 12)),

												Row(
													
													children: [

														Icon(Icons.location_on_rounded,
															size: 15,
														),

														Padding(padding: EdgeInsets.only(left: 5)),

														Text("Agência dos Correios - SAO PAULO/SP",
															
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
						),
					],
				),
			
				// ---------------------------------- //

			),
		);
	}
}