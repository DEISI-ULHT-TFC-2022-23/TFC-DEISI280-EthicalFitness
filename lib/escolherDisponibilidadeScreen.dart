import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adicionarDisponibilidadeScreen.dart.dart';
import 'disponibilidadeClass.dart';

class EscolherDisponibilidadeScreen extends StatefulWidget {
  @override
  _EscolherDisponibilidadeScreenState createState() =>
      _EscolherDisponibilidadeScreenState();
}

class _EscolherDisponibilidadeScreenState
    extends State<EscolherDisponibilidadeScreen> {
  List<Disponibilidade> disponibilidades = [];

  @override
  void initState() {
    super.initState();
    _carregarDisponibilidades();
  }

  Future<void> _carregarDisponibilidades() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('disponibilidades').get();
    setState(() {
      disponibilidades = snapshot.docs
          .map((doc) =>
              Disponibilidade.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform(
          transform: Matrix4.skewX(-0.2),
          child: Text(
            'Escolher Disponibilidade',
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
        child: disponibilidades.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: disponibilidades.length,
                itemBuilder: (context, index) {
                  final disponibilidade = disponibilidades[index];

                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Data: ${disponibilidade.dataFormatada}'),
                        Text('Hora: ${disponibilidade.horaFormatada}'),
                        TextFormField(
                          initialValue: disponibilidade.aluno,
                          onChanged: (value) {
                            setState(() {
                              disponibilidade.aluno = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Aluno',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              disponibilidade.estado = !disponibilidade.estado;
                              if (!disponibilidade.estado) {
                                disponibilidade.aluno = 'Nome do Aluno';
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: disponibilidade.estado
                                ? Colors.red
                                : Colors.green,
                          ),
                          child: Text(
                              disponibilidade.estado ? 'Desmarcar' : 'Marcar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _salvarAlteracoes,
        backgroundColor:
            const Color.fromARGB(255, 133, 0, 0), // Altere a cor aqui
        child: const Icon(Icons.save),
      ),
    );
  }

  Future<void> _salvarAlteracoes() async {
    final batch = FirebaseFirestore.instance.batch();

    for (var disponibilidade in disponibilidades) {
      final disponibilidadeRef = FirebaseFirestore.instance
          .collection('disponibilidades')
          .doc(disponibilidade.id);

      batch.update(disponibilidadeRef, disponibilidade.toJson());
    }

    await batch.commit();
  }
}
