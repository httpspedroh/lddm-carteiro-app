import 'package:flutter/material.dart';

// ------------------------------------------------------------------------------------------------- //

void main() {

  	runApp(const MyApp());
}

// ------------------------------------------------------------------------------------------------- //

class MyApp extends StatelessWidget {
	
  	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {

		return MaterialApp(

			title: 'Postino',
			debugShowCheckedModeBanner: false,
			home: const MyHomePage(title: 'Postino'),
			themeMode: ThemeMode.dark, 

			theme: ThemeData(

				brightness: Brightness.light,
			),

			darkTheme: ThemeData(

				brightness: Brightness.dark,
			),

		);
	}
}

// ------------------------------------------------------------------------------------------------- //

class MyHomePage extends StatefulWidget {

  	const MyHomePage({super.key, required this.title});

  	final String title;

  	@override
  	State<MyHomePage> createState() => _MyHomePageState();
}

// ------------------------------------------------------------------------------------------------- //

class _MyHomePageState extends State<MyHomePage> {

  	int _counter = 0;

	void _decrementCounter() {

		setState(() {
			_counter--;
		});
	}

	void _incrementCounter() {
		
		setState(() {
			_counter++;
		});
	}

	// ------------------------------------------------------------ //

  	@override
  	Widget build(BuildContext context) {

		return Scaffold(

			// ---------------------------------- //

			appBar: AppBar(

				leading: const Icon(Icons.menu),
				// text with counter variable
				title: const Center(child: Text("Todos")),
				actions: const [

					Padding(

						padding: EdgeInsets.symmetric(horizontal: 16),
						child: Icon(Icons.search),
					),
				],
			),

			// ---------------------------------- //

			body: Column(

				children: [

					// ---------------------------------- //
					
					Expanded(

						child: ListView.builder(

							itemCount: 5,
							itemBuilder: (context, index) {

								return Container(
									
									color: index % 2 != 0 ? Colors.transparent : Colors.black26,
									// padding: const EdgeInsets.only(bottom: 3),
									child: Row(
						
										children: [
											
											Container(

												height: 90,
												width: 100,
												padding: const EdgeInsets.only(top: 17, bottom: 17),
												child: const CircleAvatar(

													backgroundColor: Colors.purple,
													radius: 30,
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
																
																children: const [

																	Padding(padding: EdgeInsets.only(top: 15)),

																	Text("Switch Game",

																		textAlign: TextAlign.center,
																		style: TextStyle(

																			fontSize: 18,
																			fontWeight: FontWeight.bold,
																		),
																	),

																	Spacer(),

																	Text("13 min atrás",

																		style: TextStyle(

																			fontSize: 10,
																			fontWeight: FontWeight.bold,
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
								);
							},
						),
					),

					// ---------------------------------- //
				],
			),
			// ---------------------------------- //

			floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
			floatingActionButton: Row(

				mainAxisAlignment: MainAxisAlignment.spaceAround,
				children: [

					FloatingActionButton(

						onPressed: _incrementCounter,
						tooltip: 'Increment',
						backgroundColor: Colors.green,
						child: const Icon(Icons.add),
					),

					FloatingActionButton(

						onPressed: _decrementCounter,
						tooltip: 'Decrement',
						backgroundColor: Colors.red,
						child: const Icon(Icons.remove),
					),
				],
			),
		);
  	}
}
