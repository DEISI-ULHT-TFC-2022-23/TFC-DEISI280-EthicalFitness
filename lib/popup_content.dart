import 'package:ethicalfitness_2/aula.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarkAulaPopupContent extends StatelessWidget {
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
                  subtitle: Text(aula.data.toString()),
                  onTap: () {
                    if (aula.isMarcada) {
                      // Aula já está marcada, então desmarca
                      FirebaseFirestore.instance
                          .collection('aulas')
                          .doc(aula.id)
                          .update({'isMarcada': false});
                    } else {
                      // Aula não está marcada, então marca
                      FirebaseFirestore.instance
                          .collection('aulas')
                          .doc(aula.id)
                          .update({'isMarcada': true});
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
                  subtitle: Text(aula.data.toString()),
                  onTap: () {
                    if (aula.isMarcada) {
                      // Aula já está marcada, então desmarca
                      FirebaseFirestore.instance
                          .collection('aulas')
                          .doc(aula.id)
                          .update({'isMarcada': false});
                    } else {
                      // Aula não está marcada, então marca
                      FirebaseFirestore.instance
                          .collection('aulas')
                          .doc(aula.id)
                          .update({'isMarcada': true});
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
