class Paciente {
  String id;
  String nombre;
  int edad;
  String diagnostico;

  Paciente({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.diagnostico,
  });

  factory Paciente.fromMap(Map<String, dynamic> map) {
    return Paciente(
      id: map['id'] as String,
      nombre: map['nombre'] as String,
      edad: map['edad'] is int ? map['edad'] as int : int.parse(map['edad'].toString()),
      diagnostico: map['diagnostico'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'edad': edad,
      'diagnostico': diagnostico,
    };
  }
}
