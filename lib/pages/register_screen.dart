/*
import 'package:final_proyect/classes/api_manager.dart';
import 'package:final_proyect/widgets/button_orange.dart';
import 'package:final_proyect/widgets/inputregister.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _key,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(15, 67, 116, 1),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Registrate',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          InputRegister(
                            controller: cedulaController,
                            inputIcon: Icons.credit_card_sharp,
                            title: 'Cedula',
                          ),
                          InputRegister(
                            controller: nameController,
                            inputIcon: Icons.person,
                            title: 'Nombre',
                          ),
                          InputRegister(
                            controller: lastnameController,
                            inputIcon: Icons.person,
                            title: 'Apellido',
                          ),
                          InputRegister(
                            controller: emailController,
                            inputIcon: Icons.email,
                            title: 'Correo',
                          ),
                          InputRegister(
                            controller: phoneController,
                            inputIcon: Icons.phone,
                            title: 'Telefono',
                          ),
                          InputRegister(
                            controller: passwordController,
                            inputIcon: Icons.password,
                            title: 'Contraseña',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonOrange(
                title: 'Registrarse',
                onPressed: () {
                  APIManager.sendDataToAPI(
                      context,
                      cedulaController.text,
                      nameController.text,
                      lastnameController.text,
                      emailController.text,
                      phoneController.text,
                      passwordController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:final_proyect/classes/api_manager.dart';
import 'package:final_proyect/widgets/button_orange.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(15, 67, 116, 1),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  height: MediaQuery.of(context).size.height * 0.75, // Aumenté el alto para los campos
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            'Registrate',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 30),
                          // Campo Cédula
                          TextFormField(
                            controller: cedulaController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.credit_card_sharp, color: Colors.white),
                              labelText: 'Cédula',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Ingrese su cédula";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          // Campo Nombre
                          TextFormField(
                            controller: nameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person, color: Colors.white),
                              labelText: 'Nombre',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Ingrese su nombre";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          // Campo Apellido
                          TextFormField(
                            controller: lastnameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person, color: Colors.white),
                              labelText: 'Apellido',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Ingrese su apellido";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          // Campo Correo
                          TextFormField(
                            controller: emailController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email, color: Colors.white),
                              labelText: 'Correo',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Ingrese su correo";
                              }
                              if(!value.contains('@') || !value.contains('.')) {
                                return "Correo inválido";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          // Campo Teléfono
                          TextFormField(
                            controller: phoneController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone, color: Colors.white),
                              labelText: 'Teléfono',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Ingrese su teléfono";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          // Campo Contraseña
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password, color: Colors.white),
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Ingrese una contraseña";
                              }
                              if(value.length <= 6) {
                                return "Mínimo 6 caracteres";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ButtonOrange(
                title: 'Registrarse',
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    APIManager.sendDataToAPI(
                      context,
                      cedulaController.text,
                      nameController.text,
                      lastnameController.text,
                      emailController.text,
                      phoneController.text,
                      passwordController.text
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}