import 'package:ethicalfitness_2/detailsTrainingPlan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingPlanPage extends StatefulWidget {
  static const String title = 'Setup Firebase';

  const TrainingPlanPage({Key? key}) : super(key: key);

  @override
  _TrainingPlanPage createState() => _TrainingPlanPage();
}

class _TrainingPlanPage extends State<TrainingPlanPage> {
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser?.uid ==
        'uAUvczVwLWTsSFTFYXm0BhXNwJg2') {
      return Scaffold(
        appBar: AppBar(
          title: Transform(
            transform: Matrix4.skewX(-0.2),
            child: Text(
              'Plano de treino',
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
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        body: _buildTrainerListView(context),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Transform(
            transform: Matrix4.skewX(-0.2),
            child: Text(
              'Plano de treino',
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
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        body: _buildListView(context),
      );
    }
  }

  ListView _buildListView(BuildContext context) {
    final List<String> exercicios = [
      '3 séries  de 12 repetições - Burpies',
      '3 séries  de 1:40 min - Prancha',
      '3 séries  de 15 repetições - Abdominais normais',
      '3 séries  de 10 repetições - Flexões',
      '2 séries  de 15 repetições - Agachamentos',
      '2 séries  de 2:00 min - Saltar a corda',
      '3 séries  de 12 repetições - Biceps com halter',
      '2 séries  de 8 repetições - Biceps com barra curva',
      '2 séries  de 8 repetições - Triceps com corda',
      '1 série  de 2:00 min - Flexão com Burpies'
    ];

    final List<String> fotosExercicios = [
      'images/Exercicio-burpies.png',
      'images/Exercicio-prancha.png',
      'images/Exercicio-abdominal.jpg',
      'images/Exercicio-flexoes.jpg',
      'images/Exercicio-agachamento.jpg',
      'images/Exercicio-corda.jpeg',
      'images/Exercicio-bicep.jpg',
      'images/Exercicio-bicepBarra.jpg',
      'images/Exercicio-triceps.jpg',
      'images/Exercicio-burpies.png'
    ];

    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index) {
        return Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: ListTile(
            title: Text(
              'Exercício ${index + 1}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              exercicios[index % exercicios.length],
              style: const TextStyle(
                color: Color.fromARGB(255, 59, 59, 59),
              ),
            ),
            leading: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.2,
              child: Image(
                image: AssetImage(fotosExercicios[index]),
                fit: BoxFit.cover,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsTrainingPlan(index),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  ListView _buildTrainerListView(BuildContext context) {
    final List<String> nomes = [
      'Paulo',
      'Sandra',
      'Manuel',
      'Gonçalo'
    ]; // Lista de nomes

    return ListView(
      children: [
        const SizedBox(height: 50),
        const Center(
          child: Text(
            'Os seus alunos:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: nomes.length,
          itemBuilder: (_, index) {
            return Card(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: ListTile(
                title: Text(
                  nomes[index], // Acessando o nome pelo índice
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Lógica para atribuir o plano de treino ao nome selecionado
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 133, 0, 0),
                  ),
                  child: const Text('Atribuir plano de treino'),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
