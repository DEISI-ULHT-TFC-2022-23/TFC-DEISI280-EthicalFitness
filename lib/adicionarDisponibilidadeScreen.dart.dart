import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'disponibilidadeClass.dart';

class AdicionarDisponibilidadeScreen extends StatefulWidget {
  @override
  _AdicionarDisponibilidadeScreenState createState() =>
      _AdicionarDisponibilidadeScreenState();
}

class _AdicionarDisponibilidadeScreenState
    extends State<AdicionarDisponibilidadeScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _dataHora;

  TextEditingController _dataController = TextEditingController();
  TextEditingController _horaController = TextEditingController();

  @override
  void dispose() {
    _dataController.dispose();
    _horaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final personalTrainerId = 'seu_personal_trainer_id_aqui';

    return Scaffold(
      appBar: AppBar(
        title: Transform(
          transform: Matrix4.skewX(-0.2),
          child: Text(
            'Treinos Personalizados',
            style: GoogleFonts.anton(
              textStyle: const TextStyle(
                fontSize: 27,
                color: Color.fromARGB(255, 238, 238, 238),
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 25.0),
            Text(
              'Adicionar de disponibilidades',
              style: GoogleFonts.bebasNeue(
                textStyle: const TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dataController,
                      decoration: const InputDecoration(
                        labelText: 'Data (AAAA-MM-DD)',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma data válida';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: _horaController,
                      decoration: const InputDecoration(
                        labelText: 'Hora (HH:MM)',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma hora válida';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final data = _dataController.text;
                final hora = _horaController.text;

                final dataHoraString = '$data $hora';
                final dataHora =
                    DateFormat('yyyy-MM-dd HH:mm').parse(dataHoraString);

                setState(() {
                  _dataHora = dataHora;
                });

                _adicionarDisponibilidade();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 133, 0, 0),
              ),
              child: const Text('Adicionar'),
            ),
            const SizedBox(height: 40.0),
            Text(
              'Lista de disponibilidades',
              style: GoogleFonts.bebasNeue(
                textStyle: const TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('disponibilidades')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final disponibilidades = snapshot.data!.docs
                        .map((doc) => Disponibilidade.fromJson(
                            doc.data() as Map<String, dynamic>))
                        .toList();

                    disponibilidades
                        .sort((a, b) => b.dataHora.compareTo(a.dataHora));

                    return ListView.separated(
                      itemCount: disponibilidades.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5.0),
                      itemBuilder: (context, index) {
                        final disponibilidade = disponibilidades[index];
                        final dateFormat = DateFormat('dd-MM-yyyy');
                        final timeFormat = DateFormat('HH:mm');
                        final formattedDate =
                            dateFormat.format(disponibilidade.dataHora);
                        final formattedTime =
                            timeFormat.format(disponibilidade.dataHora);

                        return Dismissible(
                          key: Key(disponibilidade.id),
                          onDismissed: (_) {
                            _excluirDisponibilidade(disponibilidade.id);
                          },
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16.0),
                            child: const Icon(Icons.delete,
                                color: Color.fromARGB(255, 236, 236, 236)),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                  255, 17, 17, 17), // Cor de fundo preto
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Horário: ${disponibilidade.dataFormatada} às $formattedTime',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 236, 236, 236),
                                    ), // Cor do texto branco
                                  ),
                                  Text(
                                    'Aluno: ${disponibilidade.aluno}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 236, 236, 236),
                                    ), // Cor do texto branco
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: disponibilidade.estado
                                    ? const Icon(
                                        Icons.check,
                                        color: Color.fromARGB(255, 0, 113, 21),
                                      )
                                    : const Icon(
                                        Icons.close,
                                        color: Color.fromARGB(255, 172, 0, 0),
                                      ),
                                onPressed: () {
                                  _excluirDisponibilidade(disponibilidade.id);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Ocorreu um erro ao carregar os dados');
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _adicionarDisponibilidade() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final disponibilidadeRef =
          FirebaseFirestore.instance.collection('disponibilidades');

      final dataFormatada = DateFormat('dd-MM-yyyy').format(_dataHora);
      final horaFormatada = DateFormat('HH:mm').format(_dataHora);

      final novaDisponibilidade = Disponibilidade(
        id: disponibilidadeRef.doc().id,
        dataHora: _dataHora,
        dataFormatada: dataFormatada,
        horaFormatada: horaFormatada,
        aluno: "Nome do Aluno",
        estado: false,
      );

      await disponibilidadeRef
          .doc(novaDisponibilidade.id)
          .set(novaDisponibilidade.toJson());
    }
  }

  Future<void> _excluirDisponibilidade(String id) async {
    final disponibilidadeRef =
        FirebaseFirestore.instance.collection('disponibilidades');

    await disponibilidadeRef.doc(id).delete();
  }
}
