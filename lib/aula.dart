import 'package:cloud_firestore/cloud_firestore.dart';

class Aula {
  String id;
  final String tipo;
  final DateTime data;
  final bool isMarcada;

  Aula({
    this.id = '',
    required this.tipo,
    required this.data,
    this.isMarcada = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipo': tipo,
        'data': data,
        'isMarcada': isMarcada,
      };

  static Aula fromJson(Map<String, dynamic> json) => Aula(
        id: json['id'] ?? '',
        tipo: json['tipo'],
        data: (json['data'] as Timestamp).toDate(),
        isMarcada: json['isMarcada'],
      );
}
