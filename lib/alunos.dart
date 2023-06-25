class Alunos {
  final String id;
  final String nome;
  final List<String>
      disponibilidades; // Lista de IDs das disponibilidades no calendário

  Alunos({
    required this.id,
    required this.nome,
    required this.disponibilidades,
  });

  factory Alunos.fromJson(Map<String, dynamic> json) {
    return Alunos(
      id: json['id'],
      nome: json['nome'],
      disponibilidades: List<String>.from(json['disponibilidades']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'disponibilidades': disponibilidades,
    };
  }
}
