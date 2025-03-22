import 'package:flutter/material.dart';
import 'package:proyecto_final/pages/login_page.dart';

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado
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
          // Contenido centrado
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Estamos trabajando en algo grande",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(227, 254, 247, 1),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Este apartado estará disponible pronto. Gracias por tu paciencia.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(227, 254, 247, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(227, 254, 247, 1),
                    foregroundColor: const Color.fromRGBO(0, 60, 67, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Regresar al inicio",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
