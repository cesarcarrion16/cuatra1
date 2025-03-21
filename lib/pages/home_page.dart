import 'package:flutter/material.dart';
import 'package:proyecto_final/pages/navbar/perfil/ayuda.dart';
import 'package:proyecto_final/pages/navbar/perfil/configuracion.dart';
import 'package:proyecto_final/pages/navbar/perfil/editar_perfil.dart';
import 'package:proyecto_final/pages/navbar/perfil/seguridad.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto_final/pages/login_page.dart';
import 'package:proyecto_final/pages/navbar/campus.dart';
import 'package:proyecto_final/pages/navbar/carreras.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String userEmail = "";
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // Lista de títulos para cada página
  final List<String> _pageTitles = [
    'Inicio',
    'Campus',
    'Carreras',
    'Editar Perfil',
    'Configuración',
    'Seguridad',
    'Ayuda',
  ];

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300), // Duración de la animación
      curve: Curves.easeInOut, // Curva de animación
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_pageTitles[_selectedIndex],style: TextStyle(fontWeight: FontWeight.bold)), // Aquí mostramos el título de la página actual
          ],
        ),
        backgroundColor: Color.fromRGBO(227, 254, 247, 1),
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
      ),
      drawer: Drawer(
        backgroundColor: Color.fromRGBO(0, 60, 67, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userName),
              accountEmail: Text(userEmail),
              currentAccountPicture: CircleAvatar(
  backgroundImage: AssetImage("images/avatar.jpeg"),
)
              ,
              decoration: BoxDecoration(
                color: Color.fromRGBO(19, 93, 102, 1),
              ),
            ),
            _buildDrawerItem(Icons.home, 'Inicio', 0),
            _buildDrawerItem(Icons.school, 'Campus', 1),
            _buildDrawerItem(Icons.book, 'Carreras', 2),
            _buildProfileMenu(),
            Divider(),
            _buildDrawerItem(Icons.exit_to_app, 'Cerrar Sesión', -1),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildHomePage(),
          NavbarCampus(),
          NavbarCarreras(),
          NavbarEditarPerfil(),
          NavbarConfiguracion(),
          NavbarSeguridad(),
          NavbarAyuda(),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String text, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: () {
        if (index == -1) {
          _confirmLogout(context);
        } else {
          _onItemTapped(index);
          Navigator.pop(context);
        }
      },
    );
  }

Widget _buildProfileMenu() {
  return ExpansionTile(
    leading: const Icon(Icons.person, color: Colors.white),
    title: const Text('Perfil', style: TextStyle(color: Colors.white)),
    children: [
      Container(
        color: const Color.fromRGBO(19, 93, 102, 1), // Fondo para Configuración
        child: _buildDrawerItem(Icons.edit, 'Editar Perfil', 3),
      ),
      Container(
        color: const Color.fromRGBO(19, 93, 102, 1), // Fondo para Configuración
        child: _buildDrawerItem(Icons.settings, 'Configuración', 4),
      ),
      Container(
        color: const Color.fromRGBO(19, 93, 102, 1), // Fondo para Seguridad
        child: _buildDrawerItem(Icons.security, 'Seguridad', 5),
      ),
      Container(
        color: const Color.fromRGBO(19, 93, 102, 1), // Fondo para Ayuda
        child: _buildDrawerItem(Icons.help, 'Ayuda', 6),
      ),
    ],
  );
}

  Widget _buildHomePage() {
    return Stack(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Center(
                  child: Column(
                    children: [
                      Image.asset('images/LogoSA.png', height: 200),
                      const SizedBox(height: 20),
                      Text(
                        "Bienvenido, $userName",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(227, 254, 247, 1),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

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
                await prefs.remove('email');
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
}
