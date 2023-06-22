import 'package:cloud_firestore/cloud_firestore.dart';

class Aula {
  String id;
  final String tipo;
  final DateTime data_inicio;
  final DateTime data_fim;
  final bool isMarcada;

  Aula({
    this.id = '',
    required this.tipo,
    required this.data_inicio,
    required this.data_fim,
    this.isMarcada = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipo': tipo,
        'data_inicio': data_inicio,
        'data_fim': data_fim,
        'isMarcada': isMarcada,
      };

  static Aula fromJson(Map<String, dynamic> json) => Aula(
        id: json['id'] ?? '',
        tipo: json['tipo'],
        data_inicio: (json['data_inicio'] as Timestamp).toDate(),
        data_fim: (json['data_fim'] as Timestamp).toDate(),
        isMarcada: json['isMarcada'],
      );
}
