import 'package:cloud_firestore/cloud_firestore.dart';

class Treino {
  String id;
  final String pt;
  final DateTime data;
  final bool isMarcada;

  Treino({
    this.id = '',
    required this.pt,
    required this.data,
    this.isMarcada = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'pt': pt,
        'data': data,
        'isMarcada': isMarcada,
      };

  static Treino fromJson(Map<String, dynamic> json) => Treino(
        id: json['id'] ?? '',
        pt: json['pt'],
        data: (json['data'] as Timestamp).toDate(),
        isMarcada: json['isMarcada'],
      );
}
