import 'package:ethicalfitness_2/event.dart';
import 'package:ethicalfitness_2/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'disponibilidadeClass.dart';

class EscolherDisponibilidadeScreen extends StatefulWidget {
  const EscolherDisponibilidadeScreen({super.key});

  @override
  _EscolherDisponibilidadeScreenState createState() =>
      _EscolherDisponibilidadeScreenState();
}

class _EscolherDisponibilidadeScreenState
    extends State<EscolherDisponibilidadeScreen> {
  List<Disponibilidade> disponibilidades = [];

  String nomeUsuario = '';

  @override
  void initState() {
    super.initState();
    _carregarDisponibilidades();
    _obterNomeUsuario();
  }

  Future<void> _carregarDisponibilidades() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('disponibilidades').get();
    setState(() {
      disponibilidades = snapshot.docs
          .map((doc) => Disponibilidade.fromJson(doc.data()))
          .toList();

      disponibilidades
          .sort((a, b) => a.dataHoraInicio.compareTo(b.dataHoraInicio));
    });
  }

  Future<void> _obterNomeUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        nomeUsuario = userDoc.get('nome');
      });
    }
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
        child: Column(
          children: [
            const SizedBox(height: 25.0),
            Text(
              'Escolher disponibilidades',
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
              child: disponibilidades.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: disponibilidades.length,
                      itemBuilder: (context, index) {
                        final disponibilidade = disponibilidades[index];

                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 17, 17, 17),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10.0),
                                Center(
                                  child: Text(
                                    'Dia: ${disponibilidade.dataFormatada}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 236, 236, 236),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Center(
                                  child: Text(
                                    'Duração: ${disponibilidade.horaInicioFormatada} - ${disponibilidade.horaFimFormatada}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 236, 236, 236),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        disponibilidade.estado =
                                            !disponibilidade.estado;
                                        if (!disponibilidade.estado) {
                                          disponibilidade.aluno =
                                              'Nome do Aluno';
                                        } else {
                                          disponibilidade.aluno = nomeUsuario;
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: disponibilidade.estado
                                          ? const Color.fromARGB(255, 172, 0, 0)
                                          : const Color.fromARGB(
                                              255, 0, 113, 21),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: Text(
                                      disponibilidade.estado
                                          ? 'Desmarcar'
                                          : 'Marcar',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _salvarAlteracoes,
        backgroundColor: const Color.fromARGB(255, 133, 0, 0),
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

      // Verifique se a disponibilidade foi marcada pelo aluno
      if (disponibilidade.estado) {
        final eventProvider =
            Provider.of<EventProvider>(context, listen: false);
        final event = Event(
          title: 'Disponibilidade marcada',
          description:
              'Horário: ${disponibilidade.dataFormatada} às ${disponibilidade.dataHoraInicio}',
          from: disponibilidade
              .dataHoraInicio, // Usando a mesma data e hora para "from"
          to: disponibilidade.dataHoraFim, // e "to"
        );

        eventProvider.addEvent(event);
      }
    }

    await batch.commit();
  }
}
