import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto_final/controllers/login_controller.dart';
import 'package:proyecto_final/pages/home_page.dart';
import 'package:proyecto_final/pages/register_page.dart';
import 'package:proyecto_final/pages/recover_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isButtonEnabled = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  void checkFields() {
    setState(() {
      isButtonEnabled = emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(checkFields);
    passwordController.addListener(checkFields);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animationController.forward();
    _checkSession();
  }

  Future<void> _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token_app');
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomePage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF135D66), Color(0xFF003C43)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/LogoSA.png', height: 200),
                    const SizedBox(height: 20),
                    _buildTextField(emailController, 'Correo', Icons.email),
                    const SizedBox(height: 15),
                    _buildPasswordField(),
                    const SizedBox(height: 20),
                    _buildLoginButton(),
                    const SizedBox(height: 10),
                    _buildRegisterButton(),
                    _buildForgotPasswordButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        enabledBorder: _borderStyle(),
        focusedBorder: _borderStyle(),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: passwordController,
      obscureText: !isPasswordVisible,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Contraseña',
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(Icons.lock, color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
          onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
        ),
        enabledBorder: _borderStyle(),
        focusedBorder: _borderStyle(),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: isButtonEnabled ? _handleLogin : null,
        child: const Text('Iniciar Sesión', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
      child: const Text('¿No tienes cuenta? ¡Regístrate!', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RecoverPasswordPage())),
      child: const Text('¿Olvidaste tu contraseña?', style: TextStyle(color: Colors.white)),
    );
  }

  OutlineInputBorder _borderStyle() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    );
  }

  void _handleLogin() async {
    final response = await login(emailController.text, passwordController.text);
    if (response == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token_app');
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomePage(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    } else {
      showSnackbar("Error: Código $response");
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  }
}
