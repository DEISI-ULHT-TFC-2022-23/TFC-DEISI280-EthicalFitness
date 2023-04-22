import 'package:flutter/material.dart';

class DetailsTrainingPlan extends StatelessWidget {
  final int index;

  const DetailsTrainingPlan(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes de exercício'),
      ),
      body: Center(
        child: Text(
          'The details Page #$index',
          style: const TextStyle(fontSize: 32.0),
        ),
      ),
    );
  }
}
