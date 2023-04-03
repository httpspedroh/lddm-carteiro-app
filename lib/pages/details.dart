import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lddm_carteiro_app/components/drawer.dart';

// ------------------------------------------------------------------------------------------------- //

class Details extends StatefulWidget {

  	const Details({super.key});

  	@override
  	State<Details> createState() => _DetailsState();
}

// ------------------------------------------------------------------------------------------------- //

class _DetailsState extends State<Details> {

	// ------------------------------------------------------------ //

  	@override
  	Widget build(BuildContext context) {

		return Scaffold(

			// ---------------------------------- //

			drawer: const NavDrawer(),

			// ---------------------------------- //

			body: NestedScrollView(

        		headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {

          			return [

						SliverAppBar(

							actions: [

								IconButton(

									icon: const Icon(Icons.favorite_outline_rounded),
									onPressed: () {},
								),

								IconButton(

									icon: const Icon(Icons.archive_outlined),
									onPressed: () {},
								),

								IconButton(

									icon: const Icon(Icons.more_vert),
									onPressed: () {},
								),
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
												
												padding: EdgeInsets.only(left: 70, right: 70, top: AppBar().preferredSize.height + 30)
												,
												child: Column(
														
													children: [
														
														Row(
															
															children: const [

																Text('NL192375795BR', 
																	style: TextStyle(fontWeight: FontWeight.bold),
																),

																Padding(padding: EdgeInsets.only(right: 5)),

																Icon(Icons.flag),
															],
														),

														Row(children: const [

															Text('2 DIAS ATRÁS VIA OBJETO POSTAL'),
														]),

														const Padding(padding: EdgeInsets.only(top: 10)),

														Row(children: const [

															Text('Switch Game',
																style: TextStyle(fontSize: 30)
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
					Container(
						
						color: Colors.red,
						height: 70,
					),

					Container(
						
						color: Colors.blue,
						height: 70,
					),

					Container(
						
						color: Colors.red,
						height: 70,
					),
					],
				),
			

				// ---------------------------------- //

			),
		);
	}
}