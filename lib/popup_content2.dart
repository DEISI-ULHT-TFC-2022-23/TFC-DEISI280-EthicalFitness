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
            final aulas = snapshot.data!;
            return ListView.builder(
              itemCount: aulas.length,
              itemBuilder: (context, index) {
                final aula = aulas[index];
                return ListTile(
                  title: Text(aula.pt),
                  subtitle: Text(aula.data.toString()),
                  onTap: () {},
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
            final aulas = snapshot.data!;
            return ListView.builder(
              itemCount: aulas.length,
              itemBuilder: (context, index) {
                final aula = aulas[index];
                return ListTile(
                  title: Text(aula.pt),
                  subtitle: Text(aula.data.toString()),
                  onTap: () {},
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
