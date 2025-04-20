

class VideoModel {
  String? id;
  String? fecha;
  String? titulo;
  String? descripcion;
  String? link;

  VideoModel({this.id, this.fecha, this.titulo, this.descripcion, this.link});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fecha = json['fecha'];
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fecha'] = this.fecha;
    data['titulo'] = this.titulo;
    data['descripcion'] = this.descripcion;
    data['link'] = this.link;
    return data;
  }
}