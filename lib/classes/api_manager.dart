import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIManager {
  static Future<bool> logIn(
      BuildContext context, String username, String password) async {
    try {
      String apiUrl = 'https://adamix.net/defensa_civil/def/registro.php';
      var url = Uri.parse(apiUrl);
      var request = http.MultipartRequest('POST', url);

      // Add text fields
      request.fields['cedula'] = username;
      request.fields['clave'] = password;

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        // Verifica el contenido de la respuesta
        if (responseBody.contains('exito')) {
          // Ajusta según la respuesta real de tu API
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sesión iniciada'),
              backgroundColor: Colors.green,
            ),
          );
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Credenciales incorrectas'),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error en la conexión: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  static Future<void> sendDataToAPI(
    BuildContext context,
    String cedula,
    String nombre,
    String apellido,
    String correo,
    String telefono,
    String clave,
  ) async {
    String apiUrl = 'https://adamix.net/defensa_civil/def/registro.php';
    var url = Uri.parse(apiUrl);
    var request = http.MultipartRequest('POST', url);

    // Add text fields
    request.fields['cedula'] = cedula;
    request.fields['nombre'] = nombre;
    request.fields['apellido'] = apellido;
    request.fields['correo'] = correo;
    request.fields['telefono'] = telefono;
    request.fields['clave'] = clave;

    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuario registrado correctamente'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hubo un fallo al registrar'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
