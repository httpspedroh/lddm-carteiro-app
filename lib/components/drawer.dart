import 'package:flutter/material.dart';

// ------------------------------------------------------------------------------------------------- //

class NavDrawer extends StatelessWidget {

	const NavDrawer({super.key});

	@override
	Widget build(BuildContext context) {

		return Drawer(
			
			child: Column(
					
				children: [

					const Padding(padding: EdgeInsets.only(top: 30)),

					const Image(image: AssetImage("assets/images/logo_new.png"), height: 100),
				
					const Text("Postino",
						style: TextStyle(
							fontWeight: FontWeight.bold, 
							fontSize: 15,
						),
					), 

					const Padding(padding: EdgeInsets.only(top: 5)),

					const Text("v1.0.0",
						style: TextStyle(
	
							fontSize: 10,
						),
					),

					const Padding(padding: EdgeInsets.only(top: 30)),

					// ------------------------------------------------ //

					Expanded(child: 
							
						Column(
							
							children: [

								ListTile(

									leading: const Icon(Icons.inventory_2),
									title: const Text("Todos"),
									onTap: () => {
										Navigator.pushNamed(context, '/'),
									},
								),

								ListTile(

									leading: const Icon(Icons.favorite_border),
									title: const Text("Favoritos"),
									onTap: () => {},
								),

								ListTile(

									leading: const Icon(Icons.check),
									title: const Text("Entregues"),
									onTap: () => {},
								),

								ListTile(

									leading: const Icon(Icons.archive),
									title: const Text("Arquivados"),
									onTap: () => {},
								),
							],
						),
					),

					// ------------------------------------------------ //

					Align(

						alignment: FractionalOffset.bottomCenter,
						child: Column(
							children: [

								const Divider(

									height: 20,
									thickness: 1.5,
									color: Colors.white12,
								),

								ListTile(

									leading: const Icon(Icons.settings),
									title: const Text("Configurações"),
									onTap: () => {},
								),

								ListTile(

									leading: const Icon(Icons.info),
									title: const Text("Sobre nós"),
									onTap: () => {
										Navigator.pushNamed(context, '/about'),
									},
								),

								ListTile(

									leading: const Icon(Icons.person_add),
									title: const Text("Criar nova conta"),
									onTap: () => {
										Navigator.pushNamed(context, '/register'),
									},
								),
							],
						)
					),
				],
			),
		);
	}
}