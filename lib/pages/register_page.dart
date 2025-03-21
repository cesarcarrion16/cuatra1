import 'package:proyecto_final/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;

  void _register() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Validación de correo
    if (!EmailValidator.validate(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingrese un correo electrónico válido.',
              textAlign: TextAlign.center),
          duration: Duration(seconds: 2),
          backgroundColor:Color.fromRGBO(227, 254, 247, 1),
        ),
      );
      return;
    }

    // Validación de contraseña mejorada
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La contraseña debe tener al menos 8 caracteres.',
              textAlign: TextAlign.center),
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromRGBO(227, 254, 247, 1),
        ),
      );
      return;
    }

    // Expresión regular para validar la contraseña
    RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$');

    if (!regex.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'La contraseña debe contener al menos una letra mayúscula, una letra minúscula y un número.',
              textAlign: TextAlign.center),
          duration: Duration(seconds: 3),
          backgroundColor: Color.fromRGBO(227, 254, 247, 1),
        ),
      );
      return;
    }

    // Llamada a la función de registro
    register(nameController.text, email, password);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('Usuario creado exitosamente', textAlign: TextAlign.center),
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(19, 93, 102, 1),Color.fromRGBO(0, 60, 67, 1)],
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
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
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
                      "Ingrese sus Datos",
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(227, 254, 247, 1),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        labelStyle: const TextStyle(color: Color.fromRGBO(227, 254, 247, 1)), // Cambia el color del texto del label
                        prefixIcon: const Icon(Icons.person, color: Color.fromRGBO(227, 254, 247, 1)),
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
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo',
                        labelStyle: const TextStyle(color: Color.fromRGBO(227, 254, 247, 1)), // Cambia el color del texto del label
                        prefixIcon: const Icon(Icons.email, color: Color.fromRGBO(227, 254, 247, 1)),
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
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(color: Color.fromRGBO(227, 254, 247, 1)), // Cambia el color del texto del label
                        prefixIcon: const Icon(Icons.lock, color: Color.fromRGBO(227, 254, 247, 1)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color.fromRGBO(227, 254, 247, 1),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
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
                          foregroundColor: Color.fromRGBO(0, 60, 67, 1),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: _register,
                        child: const Text(
                          "Registrarse",
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "¿Ya tienes una cuenta? Inicia sesión",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          color: Color.fromRGBO(227, 254, 247, 1),
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
}
