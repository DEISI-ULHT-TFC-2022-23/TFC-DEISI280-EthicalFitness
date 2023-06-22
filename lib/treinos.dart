import 'package:cloud_firestore/cloud_firestore.dart';

class Treino {
  String id;
  final String pt;
  final DateTime data_inicio;
  final DateTime data_fim;
  final bool isMarcada;

  Treino({
    this.id = '',
    required this.pt,
    required this.data_inicio,
    required this.data_fim,
    this.isMarcada = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'pt': pt,
        'data_inicio': data_inicio,
        'data_fim': data_fim,
        'isMarcada': isMarcada,
      };

  static Treino fromJson(Map<String, dynamic> json) => Treino(
        id: json['id'] ?? '',
        pt: json['pt'],
        data_inicio: (json['data_inicio'] as Timestamp).toDate(),
        data_fim: (json['data_fim'] as Timestamp).toDate(),
        isMarcada: json['isMarcada'],
      );
}
