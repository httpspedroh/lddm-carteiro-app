import 'package:flutter/material.dart';

// ------------------------------------------------------------------------------------------------- //

class Login extends StatefulWidget {

  	const Login({super.key});

  	@override
  	State<Login> createState() => _LoginState();
}

// ------------------------------------------------------------------------------------------------- //

class _LoginState extends State<Login> {

	bool _obscureText = true;

	// ------------------------------------------------------------ //

  	@override
  	Widget build(BuildContext context) {

		return Scaffold(

			// ---------------------------------- //

			appBar: AppBar(

				backgroundColor: Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.secondary : null,
				leading: const Icon(Icons.arrow_back_rounded),
				centerTitle: true,
				title: const Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
			),

			// ---------------------------------- //

			body: SizedBox(

  				height: MediaQuery.of(context).size.height,
  				child: SingleChildScrollView(child:
	
					Column(

						children: [

							Center(child: SizedBox(
								
								height: 250,
								child: Image.asset('assets/images/logo_new.png', scale: 1.5),
								
							)),

							// ---------------------------------- //

							Container(
								
								padding: const EdgeInsets.only(left: 50, right: 50),
								child: Column(

									children: [
									
										// ---------------------------------- //

										// Email field
										TextFormField(
									
											keyboardType: TextInputType.emailAddress,
											maxLines: 1,
											decoration: const InputDecoration(
												
												contentPadding: EdgeInsets.symmetric(vertical: 10),
												isDense: true,
												filled: true,
												fillColor: Colors.black12,
												hintText: 'e-mail',
												prefixIcon: Icon(Icons.email),
												border: OutlineInputBorder(
													
													borderSide: BorderSide.none,
													borderRadius: BorderRadius.all(Radius.circular(100)),
												),
											),
										),

										const Padding(padding: EdgeInsets.symmetric(vertical: 5)),

										// ---------------------------------- //
										
										// Password field
										TextFormField(
									
											keyboardType: TextInputType.text,
											obscureText: _obscureText,
											enableSuggestions: false,
											autocorrect: false,
											maxLines: 1,
											decoration: InputDecoration(
												
												contentPadding: const EdgeInsets.symmetric(vertical: 10),
												isDense: true,
												filled: true,
												fillColor: Colors.black12,
												hintText: 'senha',
												prefixIcon: const Icon(Icons.lock_rounded),
												suffixIcon: IconButton(

													icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
													onPressed: () {
														setState(() {
															_obscureText = !_obscureText;
														});
													},
												),
												
												border: const OutlineInputBorder(
													
													borderSide: BorderSide.none,
													borderRadius: BorderRadius.all(Radius.circular(100)),
												),
											),
										),

										// ---------------------------------- //
										
										// Forgot password and create account buttons
										Row(children: [

											TextButton(
										
												onPressed: () {},
												child: Text('criar nova conta',
												
													style: TextStyle(
														
														decoration: TextDecoration.underline,
														color: Theme.of(context).colorScheme.onSurface,
														fontSize: 12,
													),
												),
											),

											const Spacer(),

											TextButton(
											
												onPressed: () {},
												child: Text('esqueci minha senha',
												
													style: TextStyle(
														
														color: Theme.of(context).colorScheme.onSurface,
														fontSize: 12,
													),
												),
											),
										]),

										// ---------------------------------- //

										// Login button
										const Padding(padding: EdgeInsets.symmetric(vertical: 5)),

										ElevatedButton.icon(

											onPressed: (){},

											icon: const Icon(Icons.local_shipping_rounded, 
												color: Colors.black,
												size: 23,
											),
											
											style: ElevatedButton.styleFrom(
												backgroundColor: Colors.yellow,
												foregroundColor: Colors.black,
											),

											label: const Text("Fazer login",
												
												style: TextStyle(
													color: Colors.black,
													fontSize: 14,
												),
											), 
										),
											
										const Padding(padding: EdgeInsets.symmetric(vertical: 20)),

										// ---------------------------------- //
										
										// Social media login
										Container(

											padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
											child: Row(
												
												children: [

													ElevatedButton(

														onPressed: () {},
														style: ElevatedButton.styleFrom(
															shape: const CircleBorder(),
															padding: const EdgeInsets.all(15),
															backgroundColor: const Color.fromARGB(255, 0, 95, 172),
															foregroundColor: Colors.black,
														),

														child: Image.asset('assets/images/facebook.png', 

															height: 30, 
															width: 30, 
															color: Colors.white,
														),
													),

													const Spacer(),

													ElevatedButton(

														onPressed: () {},
														style: ElevatedButton.styleFrom(
															shape: const CircleBorder(),
															padding: const EdgeInsets.all(15),
															backgroundColor: Colors.white,
															foregroundColor: Colors.black,
														),

														child: Image.asset('assets/images/google.png', 

															height: 30, 
															width: 30, 
														),
													),

													const Spacer(),

													ElevatedButton(

														onPressed: () {},
														style: ElevatedButton.styleFrom(
															shape: const CircleBorder(),
															padding: const EdgeInsets.all(15),
															backgroundColor: const Color.fromARGB(255, 77, 170, 247),
															foregroundColor: Colors.black,
														),

														child: Image.asset('assets/images/twitter.png', 

															height: 30, 
															width: 30, 
															color: Colors.white,
														),
													),
												],
											),
										)
									],
								),
							)
						],
					),
				),
			),
			
			// ---------------------------------- //

		);
  	}
}