import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'pages/all.dart';
import 'pages/details.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/about.dart';


// ------------------------------------------------------------------------------------------------- //

void main() {
	
	sqfliteFfiInit();
	databaseFactory = databaseFactoryFfi;

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
			initialRoute: "/",
			routes: {

				"/all":  (context) => const AllObjects(), // Tela principal
				"/details": (context) => const Details(), // Principal funcionalidade
				"/login": (context) => const Login(), // Login
				"/register": (context) => const Register(), // Registro
				"/about": (context) => const About(), // Sobre nós
			},

			home: const AllObjects(),

			theme: ThemeData(

				colorScheme: const ColorScheme.light(
					
					primary: Colors.black,
					secondary: Colors.yellow,
					background: Colors.white,
					error: Colors.red,
					onPrimary: Colors.black,
					onSecondary: Colors.black,
					brightness: Brightness.light,
				),
			),

			darkTheme: ThemeData(

				colorScheme: const ColorScheme.dark(
					
					primary: Colors.white,
					secondary: Colors.yellow,
					background: Colors.black,
					surface: Color.fromARGB(255, 30, 30, 30),
					onSurface: Colors.white,
					error: Colors.red,
					onPrimary: Colors.black,
					onSecondary: Colors.black,
					brightness: Brightness.dark,
				),
			),

			themeMode: ThemeMode.light,
		);
	}
}

// ------------------------------------------------------------------------------------------------- //