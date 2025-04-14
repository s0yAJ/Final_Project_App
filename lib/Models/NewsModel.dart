
class NewModels {
  bool? exito;
  List<Datos>? datos;
  String? mensaje;

  NewModels({this.exito, this.datos, this.mensaje});

  NewModels.fromJson(Map<String, dynamic> json) {
    exito = json['exito'];
    if (json['datos'] != null) {
      datos = <Datos>[];
      json['datos'].forEach((v) {
        datos!.add(Datos.fromJson(v));
      });
    }
    mensaje = json['mensaje'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exito'] = exito;
    if (datos != null) {
      data['datos'] = datos!.map((v) => v.toJson()).toList();
    }
    data['mensaje'] = mensaje;
    return data;
  }
}

class Datos {
  String? id;
  String? fecha;
  String? titulo;
  String? contenido;
  String? foto;

  Datos({this.id, this.fecha, this.titulo, this.contenido, this.foto});

  Datos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fecha = json['fecha'];
    titulo = json['titulo'];
    contenido = json['contenido'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fecha'] = fecha;
    data['titulo'] = titulo;
    data['contenido'] = contenido;
    data['foto'] = foto;
    return data;
  }
}