import 'package:flutter/material.dart';
import 'package:proyecto_final/pages/login_page.dart';
import 'package:proyecto_final/pages/welcome_page.dart';
import 'package:proyecto_final/pages/navbar/perfil/configuracion.dart';
import 'package:proyecto_final/pages/navbar/perfil/seguridad.dart';
import 'package:proyecto_final/pages/navbar/perfil/editar_perfil.dart';
import 'package:proyecto_final/pages/navbar/perfil/ayuda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/configuracion': (context) => const NavbarConfiguracion(),
        '/seguridad': (context) => const NavbarSeguridad(),
        '/editar_perfil': (context) => const NavbarEditarPerfil(),
        '/ayuda': (context) => const NavbarAyuda(),
      },
    );
  }
}
