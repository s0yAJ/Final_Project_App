import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbergueRow extends StatefulWidget {
  final dynamic title;
  final dynamic city;
  final dynamic phoneNumber;
  final dynamic capacity;
  final dynamic code;
  final dynamic coordinator;
  final dynamic lat;
  final dynamic lon;

  const AlbergueRow(
      {required this.title,
      required this.city,
      required this.phoneNumber,
      required this.capacity,
      required this.code,
      required this.coordinator,
      required this.lat,
      required this.lon});

  void showInfoPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color.fromRGBO(15, 67, 116, 1),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    city,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(239, 121, 42, 1),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    code,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(15, 67, 116, 1),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: [
                      Text(
                        'Telefono: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(15, 67, 116, 1),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '$phoneNumber',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(239, 121, 42, 1),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Capacidad: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(15, 67, 116, 1),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '$capacity',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(239, 121, 42, 1),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Coordinador: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(15, 67, 116, 1),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Text(
                          '$coordinator',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(239, 121, 42, 1),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Latitud: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(15, 67, 116, 1),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '$lat',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(239, 121, 42, 1),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Longitud: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(15, 67, 116, 1),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '$lon',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(239, 121, 42, 1),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cerrar',
                    style: TextStyle(color: Color.fromRGBO(239, 121, 42, 1)),
                  ))
            ],
          );
        });
  }

  @override
  State<AlbergueRow> createState() => AlbergueRowDesign();
}

class AlbergueRowDesign extends State<AlbergueRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.showInfoPopUp(context),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Color.fromRGBO(15, 67, 116, 1),
          width: 1.0,
        ))),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title.length > 32
                        ? '${widget.title.substring(0, 32)}...'
                        : widget.title,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(15, 67, 116, 1),
                        fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    widget.city,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color.fromRGBO(15, 67, 116, 1)),
                  ),
                  Text(
                    widget.phoneNumber,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(239, 121, 42, 1)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
