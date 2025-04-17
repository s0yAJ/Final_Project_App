class Servicio {
  final String id;
  final String nombre;
  final String descripcion;
  final String foto;

  Servicio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.foto,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) {
    return Servicio(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      foto: json['foto'],
    );
  }
}
