import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIManager {
  static Future<bool> logIn(
      BuildContext context, String username, String password) async {
    try {
      String apiUrl = 'https://adamix.net/defensa_civil/def/iniciar_sesion.php';
      var url = Uri.parse(apiUrl);
      var request = http.MultipartRequest('POST', url);

      // Add text fields
      request.fields['cedula'] = username;
      request.fields['clave'] = password;

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      var result = jsonDecode(responseBody);

      if (result["exito"] == true) {
        // Verifica el contenido de la respuesta
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sesión iniciada', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
            backgroundColor: Colors.green,
          ),
        );
        return true;

      } else if(result["exito"] == false){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Credenciales incorrectas', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            ),
          );
          return false;
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error en la conexión: ${response.statusCode}', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: No tienes acceso a internet!', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
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
