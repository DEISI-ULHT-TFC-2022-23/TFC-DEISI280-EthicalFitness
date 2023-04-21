import 'package:flutter/material.dart';

class PersonalizedWorkoutsPage extends StatelessWidget {
  const PersonalizedWorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Treinos Personalizados',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 238, 238, 238),
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        centerTitle: true,
      ),
      body: const Center(
        child: Image(
          image: AssetImage('images/treinoPersonalizado.jpg'),
        ),
      ),
    );
  }
}
