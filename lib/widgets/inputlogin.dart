import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputLogin extends StatefulWidget {
  final dynamic mode;
  final String? title;
  final dynamic inputIcon;
  final bool? isPassWord;
  final dynamic inputColor;
  final String? description;
  final dynamic inputHintColor;
  final dynamic inputFocusColor;
  final TextEditingController controller;

  const InputLogin({
    super.key,
    this.mode,
    this.title,
    this.inputIcon,
    this.inputColor,
    this.isPassWord,
    this.description,
    this.inputHintColor,
    this.inputFocusColor,
    required this.controller,
  });

  @override
  State<InputLogin> createState() => InputLoginDesign();
}

class InputLoginDesign extends State<InputLogin> {
  dynamic phantomPass;
  dynamic suffixIconSummon;

  @override
  void initState() {
    super.initState();
    setState(() {
      phantomPass = widget.isPassWord ?? false;
      suffixIconSummon = widget.isPassWord ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.mode,
      obscureText: suffixIconSummon ? true : false,
      style: const TextStyle(
        color: Color.fromRGBO(239, 121, 42, 1),
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.inputIcon ?? FontAwesomeIcons.solidUser,
          color: widget.inputColor ?? const Color.fromRGBO(0, 0, 0, 1),
          size: MediaQuery.of(context).size.height * 0.028,
        ),
        labelText: widget.title ?? "",
        labelStyle: TextStyle(
          color: widget.inputColor ?? const Color.fromRGBO(0, 0, 0, 1),
          fontWeight: FontWeight.w500,
          fontSize: MediaQuery.of(context).size.height * 0.02,
        ),
        hintText: widget.description ?? "",
        hintStyle: TextStyle(
          color: widget.inputHintColor ?? const Color.fromRGBO(0, 0, 0, 0.2),
          fontSize: MediaQuery.of(context).size.height * 0.019,
        ),
        suffixIcon: phantomPass
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    suffixIconSummon = !suffixIconSummon;
                  });
                },
                child: Icon(
                  suffixIconSummon
                      ? FontAwesomeIcons.solidEyeSlash
                      : FontAwesomeIcons.solidEye,
                  color: widget.inputColor ?? const Color.fromRGBO(0, 0, 0, 1),
                  size: MediaQuery.of(context).size.height * 0.025,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.inputHintColor ?? const Color.fromRGBO(0, 0, 0, 0.2),
            width: MediaQuery.of(context).size.height * 0.002,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.inputFocusColor ?? const Color.fromRGBO(0, 0, 0, 1),
            width: MediaQuery.of(context).size.width * 0.002,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
