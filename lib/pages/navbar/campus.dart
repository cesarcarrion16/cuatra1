import 'package:flutter/material.dart';

class NavbarCampus extends StatelessWidget {
  const NavbarCampus({super.key});
  
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
                Text(
                  "Estamos trabajando en algo grande",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(227, 254, 247, 1),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Este apartado estará disponible pronto. Gracias por tu paciencia.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(227, 254, 247, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
