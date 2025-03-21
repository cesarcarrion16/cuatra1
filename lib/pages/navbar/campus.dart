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
                colors: [Color.fromRGBO(19, 93, 102, 1),Color.fromRGBO(0, 60, 67, 1)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          // Contenido centrado
          Center(
            child: Text(
              "Próximamente",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(227, 254, 247, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
