// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../assets/themeprovider.dart';

// ------------------------------------------------------------------------------------------------- //

class NavDrawer extends StatefulWidget {

	const NavDrawer({Key? key}) : super(key: key);

	@override
	_NavDrawerState createState() => _NavDrawerState();
}

// ------------------------------------------------------------------------------------------------- //

class _NavDrawerState extends State<NavDrawer> {

	@override
	Widget build(BuildContext context) {

		return Drawer(

			child: Column(

				children: [

					const Padding(padding: EdgeInsets.only(top: 60)),

					const Image(image: AssetImage("assets/images/logo_new.png"), height: 100),

					const Text(

						"Postino",
						style: TextStyle(
							fontWeight: FontWeight.bold,
							fontSize: 15,
						),
					),

					const Padding(padding: EdgeInsets.only(top: 5)),

					const Text(

						"v1.0.0",
						style: TextStyle(
							fontSize: 10,
						),
					),

					const Padding(padding: EdgeInsets.only(top: 30)),

					Expanded(

						child: Column(

							children: [

								ListTile(
									leading: const Icon(Icons.inventory_2),
									title: const Text("Todos"),
									onTap: () {
									Navigator.pushNamed(context, '/all');
									},
								),

								ListTile(
									leading: const Icon(Icons.favorite_border),
									title: const Text("Favoritos"),
									onTap: () {
									Navigator.pushNamed(context, '/favorited');
									},
								),

								ListTile(
									leading: const Icon(Icons.check),
									title: const Text("Entregues"),
									onTap: () {
									Navigator.pushNamed(context, '/delivered');
									},
								),

								ListTile(
									leading: const Icon(Icons.archive),
									title: const Text("Arquivados"),
									onTap: () {
									Navigator.pushNamed(context, '/archived');
									},
								),
							],
						),
					),

					Align(

						alignment: FractionalOffset.bottomCenter,
						child: Column(

							children: [

								const Divider(

									height: 20,
									thickness: 1.5,
								),

								ListTile(

									leading: const Icon(Icons.nightlight_round),
									title: const Text('Modo escuro'),
									trailing: Switch(

										value: Theme.of(context).brightness == Brightness.dark,
										onChanged: (value) {

											setState(() {
												
												if (value) { Provider.of<ThemeProvider>(context, listen: false).themeMode = ThemeMode.dark; }
												else { Provider.of<ThemeProvider>(context, listen: false).themeMode = ThemeMode.light; }
											});
										},
									),
								),

								ListTile(

									leading: const Icon(Icons.info),
									title: const Text("Sobre nós"),
									onTap: () {
										Navigator.pushNamed(context, '/about');
									},
								),
							],
						),
					),
				],
			),
		);
	}
}
