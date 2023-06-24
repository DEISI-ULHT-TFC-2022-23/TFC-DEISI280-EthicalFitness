import 'package:cloud_firestore/cloud_firestore.dart';

class Disponibilidade {
  late String id;
  late DateTime dataHora;

  Disponibilidade({required this.id, required this.dataHora});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dataHora': Timestamp.fromDate(dataHora),
    };
  }

  factory Disponibilidade.fromJson(Map<String, dynamic> json) {
    return Disponibilidade(
      id: json['id'],
      dataHora: (json['dataHora'] as Timestamp).toDate(),
    );
  }
}
