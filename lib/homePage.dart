import 'package:ethicalfitness_2/adicionarAulasScreen.dart';
import 'package:ethicalfitness_2/agendaPage.dart';
import 'package:ethicalfitness_2/adicionarDisponibilidadeScreen.dart.dart';
import 'package:ethicalfitness_2/escolherAulasScreen.dart';
import 'package:ethicalfitness_2/homePage2.dart';
import 'package:ethicalfitness_2/escolherDisponibilidadeScreen.dart';
import 'package:ethicalfitness_2/trainingPlanPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import 'global.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //bool isPersonalTrainer = Globals.isPersonalTrainer;
  int _selectedIndex = 0;

  Widget _widget() {
    if (FirebaseAuth.instance.currentUser?.uid ==
        'N4cCEaXXEobgfIBkumEAwvWVktA2') {
      switch (_selectedIndex) {
        case 0:
          return const HomePage2();
        case 1:
          return const TrainingPlanPage();
        case 2:
          return const AdicionarAulasScreen();
        case 3:
          return const AdicionarDisponibilidadeScreen();
        case 4:
          return AgendaPage();
        default:
          return const HomePage2();
      }
    } else {
      switch (_selectedIndex) {
        case 0:
          return const HomePage2();
        case 1:
          return const TrainingPlanPage();
        case 2:
          return const EscolherAulasScreen();
        case 3:
          return const EscolherDisponibilidadeScreen();
        case 4:
          return AgendaPage();
        default:
          return const HomePage2();
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widget(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 133, 0, 0),
        unselectedItemColor: const Color.fromARGB(255, 240, 240, 240),
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Plano',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Aulas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Treinos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Agenda',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
