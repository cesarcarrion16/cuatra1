import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Ajusta la URL dependiendo del entorno
//const String baseUrl = 'http://10.0.2.2:8000/api/login'; // Para emuladores Android
const String baseUrl = 'http://localhost:8000/api/login'; // Para web
// const String baseUrl = 'http://192.168.x.x:8000/api/login'; // Para dispositivos físicos (ajusta tu IP local)

Future<int> login(String email, String password) async {
  try {
    var url = Uri.parse(baseUrl);
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var body = json.encode({'email': email, 'password': password});

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var message = json.decode(response.body);

      if (message.containsKey('accessToken') &&
          message['accessToken'] != null) {
        await saveUserInfo(message['accessToken'], message['user']['name'],
            message['user']['email']); // Guardar token y nombre
        return 200;
      } else {
        return 401; // Error de credenciales
      }
    } else {
      return response.statusCode; // Código de error real
    }
  } catch (e) {
    debugPrint("Error en login: $e");
    return 500; // Error de conexión
  }
}

// Guarda el token y el nombre del usuario
Future<void> saveUserInfo(String token, String name, String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token_app', token);
  await prefs.setString('user_name', name);
  await prefs.setString('user_email', email); // Guardamos el email también
}
