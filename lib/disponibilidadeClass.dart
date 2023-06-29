import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Disponibilidade {
  late String id;
  late DateTime dataHoraInicio;
  late DateTime dataHoraFim;
  late String dataFormatada;
  late String horaInicioFormatada;
  late String horaFimFormatada;
  late String aluno;
  late bool estado;

  Disponibilidade({
    required this.id,
    required this.dataHoraInicio,
    required this.dataHoraFim,
    required this.dataFormatada,
    required this.horaInicioFormatada,
    required this.horaFimFormatada,
    required this.aluno,
    required this.estado,
  });

  factory Disponibilidade.fromJson(Map<String, dynamic> json) {
    final dataHoraInicio = (json['dataHoraInicio'] as Timestamp).toDate();
    final dataHoraFim = (json['dataHoraFim'] as Timestamp).toDate();
    final dataFormatada = DateFormat('dd-MM').format(dataHoraInicio);
    final horaInicioFormatada = DateFormat('HH:mm').format(dataHoraInicio);
    final horaFimFormatada = DateFormat('HH:mm').format(dataHoraFim);

    return Disponibilidade(
      id: json['id'],
      dataHoraInicio: dataHoraInicio,
      dataHoraFim: dataHoraFim,
      dataFormatada: dataFormatada,
      horaInicioFormatada: horaInicioFormatada,
      horaFimFormatada: horaFimFormatada,
      aluno: json['aluno'],
      estado: json['estado'],
    );
  }

  DateTime get dataInicio {
    // Retornar apenas a data de início sem o horário
    final format = DateFormat('dd-MM-yyyy');
    final date = format.parse('$dataFormatada-${DateTime.now().year}');
    return date;
  }

  DateTime get dataFim {
    // Retornar apenas a data de fim sem o horário
    final format = DateFormat('dd-MM-yyyy');
    final date = format.parse('$dataFormatada-${DateTime.now().year}');
    return date;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dataHoraInicio': dataHoraInicio,
      'dataHoraFim': dataHoraFim,
      'aluno': aluno,
      'estado': estado,
    };
  }
}
