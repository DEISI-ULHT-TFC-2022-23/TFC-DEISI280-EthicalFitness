import 'package:ethicalfitness_2/treinos.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarkTreinoPopupContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: StreamBuilder<List<Treino>>(
        stream:
            FirebaseFirestore.instance.collection('treinos').snapshots().map(
                  (snapshot) => snapshot.docs
                      .map((doc) => Treino.fromJson(doc.data()))
                      .toList(),
                ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final treinos = snapshot.data!;
            return ListView.builder(
              itemCount: treinos.length,
              itemBuilder: (context, index) {
                final treino = treinos[index];
                return ListTile(
                  title: Text(treino.pt),
                  subtitle: Text(treino.data.toString()),
                  onTap: () {
                    if (index == 0 && treino.isMarcada == false) {
                      FirebaseFirestore.instance
                          .collection(
                              'treinos') // Acessa o ID da coleção com base no index
                          .doc('1Bqh8q3DJMuzRixMamL0')
                          .update({'isMarcada': true});

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Treino marcado com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (index == 1 && treino.isMarcada == false) {
                      FirebaseFirestore.instance
                          .collection(
                              'treinos') // Acessa o ID da coleção com base no index
                          .doc('AXcBWFv15HQba1ZyIo7N')
                          .update({'isMarcada': true});

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Treino marcado com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      if (index == 2 && treino.isMarcada == false) {
                        FirebaseFirestore.instance
                            .collection(
                                'treinos') // Acessa o ID da coleção com base no index
                            .doc('UnXKo23MUbiOFKXglTNg')
                            .update({'isMarcada': true});

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Treino marcado com sucesso!'),
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
            return Text('Erro ao carregar os treinos: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class UnmarkTreinoPopupContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: StreamBuilder<List<Treino>>(
        stream:
            FirebaseFirestore.instance.collection('treinos').snapshots().map(
                  (snapshot) => snapshot.docs
                      .map((doc) => Treino.fromJson(doc.data()))
                      .toList(),
                ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final treinos = snapshot.data!;
            return ListView.builder(
              itemCount: treinos.length,
              itemBuilder: (context, index) {
                final treino = treinos[index];
                return ListTile(
                  title: Text(treino.pt),
                  subtitle: Text(treino.data.toString()),
                  onTap: () {
                    if (index == 0 && treino.isMarcada == true) {
                      FirebaseFirestore.instance
                          .collection(
                              'treinos') // Acessa o ID da coleção com base no index
                          .doc('1Bqh8q3DJMuzRixMamL0')
                          .update({'isMarcada': false});

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Treino desmarcado com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (index == 1 && treino.isMarcada == true) {
                      FirebaseFirestore.instance
                          .collection(
                              'treinos') // Acessa o ID da coleção com base no index
                          .doc('AXcBWFv15HQba1ZyIo7N')
                          .update({'isMarcada': false});

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Treino desmarcado com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      if (index == 2 && treino.isMarcada == true) {
                        FirebaseFirestore.instance
                            .collection(
                                'treinos') // Acessa o ID da coleção com base no index
                            .doc('UnXKo23MUbiOFKXglTNg')
                            .update({'isMarcada': false});

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Treino desmarcado com sucesso!'),
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
            return Text('Erro ao carregar os treinos: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
