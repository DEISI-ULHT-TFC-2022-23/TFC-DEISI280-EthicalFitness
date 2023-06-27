import 'package:ethicalfitness_2/treinos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'popup_content2.dart';

enum PopupMode {
  mark,
  unmark,
}

class PersonalizedWorkoutsPage extends StatefulWidget {
  static const String title = 'Setup Firebase';

  const PersonalizedWorkoutsPage({Key? key}) : super(key: key);

  @override
  _PersonalizedWorkoutsPage createState() => _PersonalizedWorkoutsPage();
}

class _PersonalizedWorkoutsPage extends State<PersonalizedWorkoutsPage> {
  Stream<List<Treino>> readUsers() => FirebaseFirestore.instance
      .collection('treinos')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Treino.fromJson(doc.data())..id = doc.id)
          .toList());

  PopupMode? _popupMode;

  void _handleMarkTreinoClick() {
    setState(() {
      _popupMode = PopupMode.mark;
    });
  }

  void _handleUnmarkTreinoClick() {
    setState(() {
      _popupMode = PopupMode.unmark;
    });
  }

  void _handleCreateTreinoClick() {
    // Lógica para criar aula
  }

  void _handleDeleteTreinoClick() {
    // Lógica para apagar aula
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform(
          transform: Matrix4.skewX(-0.2),
          child: Text(
            'Treinos Personalizados',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const Image(
                image: AssetImage('images/treinoPersonalizado.jpg'),
              ),
            ),
            const SizedBox(height: 35),
            const Text(
              'Treinos disponíveis',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<Treino>>(
                stream: readUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      'Não tem dados! ${snapshot.error}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final users = snapshot.data!;

                    return ListView(
                      children: users.map(buildUser).toList(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (FirebaseAuth.instance.currentUser?.uid !=
                    'N4cCEaXXEobgfIBkumEAwvWVktA2')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: _handleMarkTreinoClick,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 133, 0, 0),
                      ),
                      child: const Text('Marcar treino'),
                    ),
                  ),
                if (FirebaseAuth.instance.currentUser?.uid !=
                    'N4cCEaXXEobgfIBkumEAwvWVktA2')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: _handleUnmarkTreinoClick,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 133, 0, 0),
                      ),
                      child: const Text('Desmarcar treino'),
                    ),
                  ),
                if (FirebaseAuth.instance.currentUser?.uid ==
                    'N4cCEaXXEobgfIBkumEAwvWVktA2')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: _handleCreateTreinoClick,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 133, 0, 0),
                      ),
                      child: const Text('Criar treino'),
                    ),
                  ),
                if (FirebaseAuth.instance.currentUser?.uid ==
                    'N4cCEaXXEobgfIBkumEAwvWVktA2')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: _handleDeleteTreinoClick,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 133, 0, 0),
                      ),
                      child: const Text('Apagar treino'),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: _popupMode != null,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _popupMode = null;
            });
          },
          child: const Icon(Icons.close),
        ),
      ),
      bottomSheet: _buildPopupContent(),
    );
  }

  Widget buildUser(Treino user) => ListTile(
        leading: Container(
          width: 50, // Ajuste a largura conforme necessário
          height: 50, // Ajuste a altura conforme necessário
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 0, 60, 145),
          ),
          child: Center(
            child: Text(
              DateFormat('dd/MM').format(user.data_inicio),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14, // Ajuste o tamanho da fonte conforme necessário
              ),
            ),
          ),
        ),
        title: Text(
          user.pt,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          DateFormat('HH:mm').format(user.data_inicio),
          style: const TextStyle(color: Colors.white),
        ),
        trailing: FirebaseAuth.instance.currentUser?.uid ==
                'N4cCEaXXEobgfIBkumEAwvWVktA2'
            ? null
            : Icon(
                user.isMarcada ? Icons.check : Icons.close,
                color: user.isMarcada
                    ? const Color.fromARGB(255, 0, 113, 21)
                    : const Color.fromARGB(255, 172, 0, 0),
              ),
      );

  Widget _buildPopupContent() {
    if (_popupMode == PopupMode.mark) {
      return MarkTreinoPopupContent();
    } else if (_popupMode == PopupMode.unmark) {
      return UnmarkTreinoPopupContent();
    } else {
      return const SizedBox.shrink();
    }
  }
}
