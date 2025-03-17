// ignore_for_file: library_private_types_in_public_api

import 'package:proyecto_final/controllers/login_controller.dart';
import 'package:proyecto_final/pages/home_page.dart';
import 'package:proyecto_final/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isButtonEnabled = false;

  void checkFields() {
    setState(() {
      isButtonEnabled =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(checkFields);
    passwordController.addListener(checkFields);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(19, 93, 102, 1),
                  Color.fromRGBO(0, 60, 67, 1)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.transparent, // Cambia el color de fondo a transparente
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'images/LogoSA.png',
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Inicio de Sesión",
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(227, 254, 247, 1), // Cambia el color del texto
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      style: const TextStyle(color: Color.fromRGBO(227, 254, 247, 1)), // Cambia el color del texto
                      decoration: InputDecoration(
                        labelText: 'Correo',
                        labelStyle: const TextStyle(color: Color.fromRGBO(227, 254, 247, 1)), // Cambia el color del texto
                        prefixIcon:
                            const Icon(Icons.email, color: Color.fromRGBO(227, 254, 247, 1)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(227, 254, 247, 1)), // Cambia el color del borde
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(227, 254, 247, 1)), // Cambia el color del borde
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      style: const TextStyle(color: Color.fromRGBO(227, 254, 247, 1)), // Cambia el color del texto
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(color: Color.fromRGBO(227, 254, 247, 1)), // Cambia el color del texto
                        prefixIcon:
                            const Icon(Icons.lock, color: Color.fromRGBO(227, 254, 247, 1)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color.fromARGB(255, 148, 140, 140),
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(227, 254, 247, 1)), // Cambia el color del borde
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(227, 254, 247, 1)), // Cambia el color del borde
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(227, 254, 247, 1),
                          foregroundColor: Color.fromRGBO(0, 60, 67, 1), // Cambia el color del texto del botón
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: isButtonEnabled
                            ? () async {
                                final response = await login(
                                  emailController.text,
                                  passwordController.text,
                                );

                                debugPrint("Respuesta del login: $response");

                                if (response == 200) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String? token = prefs.getString('token_app');
                                  debugPrint("Token después del login: $token");

                                  if (token != null && token.isNotEmpty) {
                                    Navigator.pushReplacement(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                  } else {
                                    showSnackbar(
                                        "Error al obtener el token. Intente de nuevo.");
                                  }
                                } else if (response == 401) {
                                  showSnackbar(
                                      "Correo o contraseña incorrectos");
                                } else if (response == 500) {
                                  showSnackbar(
                                      "Error de conexión con el servidor");
                                } else {
                                  showSnackbar(
                                      "Error inesperado: Código $response");
                                }
                              }
                            : null,
                        child: const Text(
                          "Iniciar Sesión",
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 60, 67, 1), // Cambia el color del texto del botón
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      child: const Text(
                        "¿No tienes cuenta? ¡Regístrate!",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          color: Color.fromRGBO(227, 254, 247, 1), // Cambia el color del texto
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "¿Olvidaste tu contraseña?",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          color: Color.fromRGBO(227, 254, 247, 1), // Cambia el color del texto
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: const Color.fromARGB(255, 201, 106, 106),
      ),
    );
  }
}
