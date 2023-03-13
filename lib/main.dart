import 'package:flutter/material.dart';

void main() {
  	runApp(const MyApp());
}

class MyApp extends StatelessWidget {

	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {

		return MaterialApp(

			title: 'Flutter Demo',
			debugShowCheckedModeBanner: false,
			theme: ThemeData.light(),
			home: const MyHomePage(title: 'Flutter Demo Home Page'),
		);
	}
}

class MyHomePage extends StatefulWidget {

  	const MyHomePage({super.key, required this.title});

  	final String title;

	@override
	State<MyHomePage> createState() => _MyHomePageState();
}

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

	@override
	Widget build(BuildContext context) {
		
		return Scaffold(

			appBar: AppBar(
				title: Text(widget.title),
			),

			body: Center(

				child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[

					const Text('Você apertou o botão esse número de vezes:'),
				
					Text('$_counter',
						
						style: Theme.of(context).textTheme.headline4,
					),
				]),
			),

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
			)
		);
	}
}