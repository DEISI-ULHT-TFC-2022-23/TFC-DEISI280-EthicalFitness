import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Aulas {
  late String id;
  late DateTime dataHora;
  late String dataFormatada;
  late String horaFormatada;
  late String aluno;
  late bool estado;
  late String tipo;

  Aulas({
    required this.id,
    required this.dataHora,
    required this.dataFormatada,
    required this.horaFormatada,
    required this.aluno,
    required this.estado,
    required this.tipo,
  });

  factory Aulas.fromJson(Map<String, dynamic> json) {
    final dataHora = (json['dataHora'] as Timestamp).toDate();
    final dataFormatada = DateFormat('dd-MM').format(dataHora);
    final horaFormatada = DateFormat('HH:mm').format(dataHora);

    return Aulas(
      id: json['id'],
      dataHora: dataHora,
      dataFormatada: dataFormatada,
      horaFormatada: horaFormatada,
      aluno: json['aluno'],
      estado: json['estado'],
      tipo: json['tipo'],
    );
  }

  DateTime get data {
    // Retornar apenas a data sem o horário
    final format = DateFormat('dd-MM-yyyy');
    final date = format.parse('$dataFormatada-${DateTime.now().year}');
    return date;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dataHora': dataHora,
      'aluno': aluno,
      'estado': estado,
      'tipo': tipo,
    };
  }
}
