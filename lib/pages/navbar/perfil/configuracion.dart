import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NavbarConfiguracion(),
    );
  }
}

class NavbarConfiguracion extends StatelessWidget {
  const NavbarConfiguracion({super.key});

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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildConfigButton(
                          icon: Icons.notifications,
                          text: "Notificaciones",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NotificacionesPage()),
                            );
                          },
                        ),
                        _buildConfigButton(
                          icon: Icons.lock,
                          text: "Cambiar Contraseña",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CambiarContrasenaPage()),
                            );
                          },
                        ),
                        _buildConfigButton(
                          icon: Icons.language,
                          text: "Idioma",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const IdiomaPage()),
                            );
                          },
                        ),
                        _buildConfigButton(
                          icon: Icons.info,
                          text: "Acerca de la Aplicación",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AcercaPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromRGBO(227, 254, 247, 1).withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Color.fromRGBO(227, 254, 247, 1), size: 28),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(fontSize: 18, color: Color.fromRGBO(227, 254, 247, 1)),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Color.fromRGBO(227, 254, 247, 1), size: 20),
          ],
        ),
      ),
    );
  }
}

// ---------------------
// Pantallas de ejemplo
// ---------------------

class NotificacionesPage extends StatelessWidget {
  const NotificacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage(context, "Notificaciones");
  }
}

class CambiarContrasenaPage extends StatelessWidget {
  const CambiarContrasenaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage(context, "Cambiar Contraseña");
  }
}

class IdiomaPage extends StatelessWidget {
  const IdiomaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage(context, "Idioma");
  }
}

class AcercaPage extends StatelessWidget {
  const AcercaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage(context, "Acerca de la Aplicación");
  }
}

// ---------------------
// Función para generar páginas con el diseño deseado
// ---------------------
Widget _buildPage(BuildContext context, String title) {
  return Scaffold(
    appBar: AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(227, 254, 247, 1),
              Color.fromRGBO(119, 176, 170, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      title: Text(
        title, // Aquí se coloca el título dinámico
        style: const TextStyle(color: Color.fromRGBO(0, 60, 67, 1)),
      ),
    ),
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(19, 93, 102, 1),
            Color.fromRGBO(0, 60, 67, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: const Text(
          "Próximamente", // Este texto es el que se muestra centrado
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromRGBO(227, 254, 247, 1)),
        ),
      ),
    ),
  );
}
