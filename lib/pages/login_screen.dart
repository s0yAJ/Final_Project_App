import 'package:final_proyect/classes/api_manager.dart';
import 'package:final_proyect/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;

// Widgets
import 'package:final_proyect/widgets/inputlogin.dart';
import 'package:final_proyect/widgets/button_orange.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => LoginDesign();
}

class LoginDesign extends State<LoginScreen> {
  TextEditingController userController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  final _key = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      //drawer: LoginDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              child: FadeInUp(
                duration: const Duration(seconds: 1),
                child: Center(
                  child: Image.asset('assets/banner.png'),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Column(
                children: [
                  Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: userController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Agrega un usuario!";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Usuario",
                            icon: Icon(FontAwesomeIcons.solidUser,
                                color: Color.fromRGBO(239, 121, 42, 1)),
                            hintText: 'Ingrese su Usuario',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(239, 121, 42, 0.3)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(15, 67, 116, 1)),
                            ),
                          ),
                          obscureText: false,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        TextFormField(
                          controller: passWordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Agrega una contasena!";
                            }
                            if(value.length < 4){
                              return "caracteres minimo es de 4";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Contrasena",
                            icon: Icon(FontAwesomeIcons.solidUser,
                                color: Color.fromRGBO(239, 121, 42, 1)),
                            hintText: 'Ingrese su contrasena',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(239, 121, 42, 0.3)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(15, 67, 116, 1)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // InputLogin(
                  //   controller: passWordController,
                  //   mode: TextInputType.name,
                  //   title: "Contraseña",
                  //   inputIcon: FontAwesomeIcons.solidUser,
                  //   isPassWord: true,
                  //   inputColor: const Color.fromRGBO(239, 121, 42, 1),
                  //   description: "Ingrese su Contraseña",
                  //   inputHintColor: const Color.fromRGBO(239, 121, 42, 0.3),
                  //   inputFocusColor: const Color.fromRGBO(15, 67, 116, 1),
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  ButtonOrange(
                      title: "Iniciar Sesión",
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          bool loginSuccess = await APIManager.logIn(context,
                              userController.text, passWordController.text);

                          if (loginSuccess && mounted) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        }
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: Text(
                      "¿Aun no eres miembro? Haz clic para registrarte",
                      style: TextStyle(
                        color: const Color.fromRGBO(15, 67, 116, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height * 0.014,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
