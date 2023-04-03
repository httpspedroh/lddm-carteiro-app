import 'package:flutter/material.dart';
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

							expandedHeight: 200.0,
							floating: false,
							pinned: true,
							
							flexibleSpace: FlexibleSpaceBar(

								centerTitle: true,
								background: Column(

									children: [

										Expanded(child: 
										
											Container(
												
												// color: Colors.red,
												padding: EdgeInsets.only(left: 70, right: 70, top: AppBar().preferredSize.height)
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
				
				body: const Center(

					child: Text("Hello world!"),
				),

				// ---------------------------------- //

			),
		);
	}
}