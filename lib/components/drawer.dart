// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatefulWidget {

	const NavDrawer({Key? key}) : super(key: key);

	@override
	_NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {

	bool _initialized = false;

	@override
	void initState() {

		super.initState();
		initializeSharedPreferences();
	}

	Future<void> initializeSharedPreferences() async {

		SharedPreferences prefs = await SharedPreferences.getInstance();
		bool isFirstExecution = prefs.getBool('first_execution') ?? true;

		if (isFirstExecution) {
			prefs.setString('uid', '-1');
			prefs.setBool('first_execution', false);
		}

		setState(() {
			_initialized = true;
		});
	}

	@override
	Widget build(BuildContext context) {

		return Drawer(

			child: _initialized ? 
				
				Column(

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

										leading: const Icon(Icons.settings),
										title: const Text("Configurações"),
										onTap: () {},
									),

									ListTile(

										leading: const Icon(Icons.info),
										title: const Text("Sobre nós"),
										onTap: () {
											Navigator.pushNamed(context, '/about');
										},
									),

									// Builder(
										
									// 	builder: 
				
									// 	(BuildContext context) {

									// 		String uid = (ModalRoute.of(context)!.settings.arguments as Map<String, String>)['uid'] ?? '-1';

									// 		return ListTile(
									
									// 			leading: Icon(uid == '-1' ? Icons.login : Icons.logout),
									// 			title:  Text(uid == '-1' ? "Fazer login" : "Sair"),
									// 			onTap: () {

									// 				if (uid == '-1') {

									// 					Navigator.pushNamed(context, '/login');
									// 				} 
									// 				else {
														
									// 					SharedPreferences.getInstance().then((prefs) {

									// 						prefs.setString('uid', '-1');
									// 						Navigator.pushNamed(context, '/login');
									// 					});
									// 				}
									// 			},
									// 		);
									// 	},
									// ),
								],
							),
						),
					],
				)
			: const CircularProgressIndicator(), // Exibe um indicador de progresso enquanto o SharedPreferences está sendo inicializado
		);
	}
}
