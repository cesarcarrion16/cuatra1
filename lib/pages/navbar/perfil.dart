// ignore_for_file: deprecated_member_use, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto_final/pages/login_page.dart';

class NavbarPerfil extends StatefulWidget {
  const NavbarPerfil({super.key});

  @override
  _NavbarPerfilState createState() => _NavbarPerfilState();
}

class _NavbarPerfilState extends State<NavbarPerfil> {
  String userName = "Usuario";
  String userEmail = "correo@example.com";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? "Usuario";
      userEmail = prefs.getString('user_email') ?? "correo@example.com";
    });
  }

  // Función para confirmar el cierre de sesión
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cierre de Sesión"),
          content: const Text("¿Deseas cerrar sesión?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('token_app');
                await prefs.remove('user_name');
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text("Sí"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(19, 93, 102, 1), Color.fromRGBO(0, 60, 67, 1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("images/default_avatar.png"),
                    backgroundColor: Color.fromRGBO(227, 254, 247, 1).withOpacity(0.2),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(227, 254, 247, 1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userEmail,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(227, 254, 247, 1),
                    ),
                  ),
                  const SizedBox(height: 30),

                  _buildProfileOption(
                    icon: Icons.settings,
                    text: "Configuración",
                    onTap: () => Navigator.pushNamed(context, "/configuracion"),
                  ),

                  _buildProfileOption(
                    icon: Icons.security,
                    text: "Seguridad",
                    onTap: () => Navigator.pushNamed(context, "/seguridad"),
                  ),

                  _buildProfileOption(
                    icon: Icons.edit,
                    text: "Editar Perfil",
                    onTap: () => Navigator.pushNamed(context, "/editar_perfil"),
                  ),

                  _buildProfileOption(
                    icon: Icons.help_outline,
                    text: "Ayuda y Soporte",
                    onTap: () => Navigator.pushNamed(context, "/ayuda"),
                  ),

                  _buildProfileOption(
                    icon: Icons.exit_to_app,
                    text: "Cerrar Sesión",
                    onTap: () => _confirmLogout(context), // Llamamos a la alerta aquí
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
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
