import 'package:flutter/material.dart';
import 'pages/all.dart';
import 'pages/details.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/about.dart';

// ------------------------------------------------------------------------------------------------- //

void main() => runApp(const MyApp());

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
				"/details": (context) => const Details(),
				"/login": (context) => const Login(),
				"/register": (context) => const Register(),
				"/about": (context) => const About(),
			},

			home: const Login(),

			theme: ThemeData(

				colorScheme: const ColorScheme.light(
					
					primary: Colors.yellow,
					secondary: Colors.yellow,
					background: Colors.white,
					error: Colors.red,
					onSurface: Colors.black,
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
					onPrimary: Colors.yellow,
					onSecondary: Colors.black,
					brightness: Brightness.dark,
				),
			),

			themeMode: ThemeMode.dark, 
		);
	}
}

// ------------------------------------------------------------------------------------------------- //