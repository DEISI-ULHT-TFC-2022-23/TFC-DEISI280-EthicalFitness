import 'package:ethicalfitness_2/aula.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'event.dart';
import 'event_provider.dart';

class MarkAulaPopupContent extends StatelessWidget {
  const MarkAulaPopupContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: StreamBuilder<List<Aula>>(
        stream: FirebaseFirestore.instance.collection('aulas').snapshots().map(
              (snapshot) => snapshot.docs
                  .map((doc) => Aula.fromJson(doc.data()))
                  .toList(),
            ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final aulas = snapshot.data!;
            return ListView.builder(
              itemCount: aulas.length,
              itemBuilder: (context, index) {
                final aula = aulas[index];
                return ListTile(
                  title: Text(aula.tipo),
                  subtitle: Text(aula.data_inicio.toString()),
                  onTap: () {
                    if (index == 0 && aula.isMarcada == false) {
                      FirebaseFirestore.instance
                          .collection(
                              'aulas') // Acessa o ID da coleção com base no index
                          .doc('379eUYq4o1K3ujIyAZow')
                          .update({'isMarcada': true});

                      // Criar um novo evento na agenda
                      EventProvider eventProvider =
                          Provider.of<EventProvider>(context, listen: false);
                      Event newEvent = Event(
                        title: aula.tipo,
                        description: 'Aula de grupo de ${aula.tipo}',
                        from: aula.data_inicio,
                        to: aula.data_fim,
                      );
                      eventProvider.addEvent(newEvent);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Aula marcada com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (index == 1 && aula.isMarcada == false) {
                      FirebaseFirestore.instance
                          .collection(
                              'aulas') // Acessa o ID da coleção com base no index
                          .doc('bTSgp1whBPauNdoZdk4r')
                          .update({'isMarcada': true});

                      // Criar um novo evento na agenda
                      EventProvider eventProvider =
                          Provider.of<EventProvider>(context, listen: false);
                      Event newEvent = Event(
                        title: aula.tipo,
                        description: 'Aula de grupo de ${aula.tipo}',
                        from: aula.data_inicio,
                        to: aula.data_fim,
                      );
                      eventProvider.addEvent(newEvent);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Aula marcada com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      if (index == 2 && aula.isMarcada == false) {
                        FirebaseFirestore.instance
                            .collection(
                                'aulas') // Acessa o ID da coleção com base no index
                            .doc('nK4bntDZrgo0usiSiHms')
                            .update({'isMarcada': true});

                        // Criar um novo evento na agenda
                        EventProvider eventProvider =
                            Provider.of<EventProvider>(context, listen: false);
                        Event newEvent = Event(
                          title: aula.tipo,
                          description: 'Aula de grupo de ${aula.tipo}',
                          from: aula.data_inicio,
                          to: aula.data_fim,
                        );
                        eventProvider.addEvent(newEvent);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Aula marcada com sucesso!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar as aulas: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class UnmarkAulaPopupContent extends StatelessWidget {
  const UnmarkAulaPopupContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: StreamBuilder<List<Aula>>(
        stream: FirebaseFirestore.instance.collection('aulas').snapshots().map(
              (snapshot) => snapshot.docs
                  .map((doc) => Aula.fromJson(doc.data()))
                  .toList(),
            ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final aulas = snapshot.data!;
            return ListView.builder(
              itemCount: aulas.length,
              itemBuilder: (context, index) {
                final aula = aulas[index];
                return ListTile(
                  title: Text(aula.tipo),
                  subtitle: Text(aula.data_inicio.toString()),
                  onTap: () {
                    if (index == 0 && aula.isMarcada == true) {
                      FirebaseFirestore.instance
                          .collection(
                              'aulas') // Acessa o ID da coleção com base no index
                          .doc('379eUYq4o1K3ujIyAZow')
                          .update({'isMarcada': false});

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Aula desmarcada com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (index == 1 && aula.isMarcada == true) {
                      FirebaseFirestore.instance
                          .collection(
                              'aulas') // Acessa o ID da coleção com base no index
                          .doc('bTSgp1whBPauNdoZdk4r')
                          .update({'isMarcada': false});

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Aula desmarcada com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      if (index == 2 && aula.isMarcada == true) {
                        FirebaseFirestore.instance
                            .collection(
                                'aulas') // Acessa o ID da coleção com base no index
                            .doc('nK4bntDZrgo0usiSiHms')
                            .update({'isMarcada': false});

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Aula desmarcada com sucesso!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar as aulas: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
