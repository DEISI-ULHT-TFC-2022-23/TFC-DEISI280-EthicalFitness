import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Disponibilidade {
  late String id;
  late DateTime dataHora;
  late String dataFormatada;
  late String horaFormatada;
  late String aluno;
  late bool estado;

  Disponibilidade({
    required this.id,
    required this.dataHora,
    required this.dataFormatada,
    required this.horaFormatada,
    required this.aluno,
    required this.estado,
  });

  factory Disponibilidade.fromJson(Map<String, dynamic> json) {
    final dataHora = (json['dataHora'] as Timestamp).toDate();
    final dataFormatada = DateFormat('dd-MM').format(dataHora);
    final horaFormatada = DateFormat('HH:mm').format(dataHora);

    return Disponibilidade(
      id: json['id'],
      dataHora: dataHora,
      dataFormatada: dataFormatada,
      horaFormatada: horaFormatada,
      aluno: json['aluno'],
      estado: json['estado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dataHora': dataHora,
      'aluno': aluno,
      'estado': estado,
    };
  }
}
