import 'package:flutter/material.dart';
import '../components/drawer.dart';

// ------------------------------------------------------------------------------------------------- //

class About extends StatefulWidget {

  	const About({super.key});

  	@override
  	State<About> createState() => _AboutState();
}

// ------------------------------------------------------------------------------------------------- //

class _AboutState extends State<About> {

	// ------------------------------------------------------------ //

  	@override
  	Widget build(BuildContext context) {

		return Scaffold(

			// ---------------------------------- //

			appBar: AppBar(

				centerTitle: true,
				title: const Text("Sobre nós", style: TextStyle(fontWeight: FontWeight.bold)),
			),

			// ---------------------------------- //

			drawer: const NavDrawer(),

			// ---------------------------------- //

			body: Padding(
        		
				padding: const EdgeInsets.all(20.0),
        		child: Column(
          
		  			children: [

            			const Image(image: AssetImage("assets/images/logo_new.png"), height: 150),
            			
						const SizedBox(height: 80),
						
						Row(
							
							children: const [
								
								Flexible(
									child: Text("Postino permite que você rastreie encomendas em qualquer parte do território brasileiro utilizando a API dos Correios.",
										textAlign: TextAlign.center,
										style: TextStyle(
											fontSize: 20,
										),
									),
								),
							]
						),

						const SizedBox(height: 100),
						
						Row(
							
							children: const [

								Flexible(
									
									child: Text("O aplicativo foi desenvolvido para a disciplina de laboratorio de desenvolvimento de dispositivos móveis no quarto período do curso de Ciência da Computação na PUC Minas.",
									
										textAlign: TextAlign.center,
										style: TextStyle(
											fontSize: 15,
											fontWeight: FontWeight.w300,
										),
									),
								),
							]
						),
           			]
				),
        	),
    	);
	}
}