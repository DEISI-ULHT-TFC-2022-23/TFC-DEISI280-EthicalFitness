import 'package:ethicalfitness_2/detailsTrainingPlan.dart';
import 'package:flutter/material.dart';

class TrainingPlanPage extends StatelessWidget {
  const TrainingPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plano de treino',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 238, 238, 238),
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        centerTitle: true,
      ),
      body: _buildListView(context),
    );
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
      'images/Exercicio-abdominal.jpg',
      'images/Exercicio-abdominal.jpg',
      'images/Exercicio-flexoes.jpg',
      'images/Exercicio-abdominal.jpg',
      'images/Exercicio-abdominal.jpg',
      'images/Exercicio-abdominal.jpg',
      'images/Exercicio-abdominal.jpg',
      'images/Exercicio-abdominal.jpg',
      'images/Exercicio-abdominal.jpg'
    ];

    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            title: Text('Exercício ${index + 1}'),
            subtitle: Text(exercicios[index % exercicios.length]),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsTrainingPlan(index)),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
