import 'package:ethicalfitness_2/aula.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'popup_content.dart';

enum PopupMode {
  mark,
  unmark,
}

class GroupClassesPage extends StatefulWidget {
  static const String title = 'Setup Firebase';

  const GroupClassesPage({Key? key}) : super(key: key);

  @override
  _GroupClassesPageState createState() => _GroupClassesPageState();
}

class _GroupClassesPageState extends State<GroupClassesPage> {
//  Stream<List<User>> readUsers() => FirebaseFirestore.instance
//      .collection('aulas')
//      .snapshots()
//      .map((snapshot) =>
//          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Stream<List<Aula>> readUsers() => FirebaseFirestore.instance
      .collection('aulas')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Aula.fromJson(doc.data())..id = doc.id)
          .toList());

  PopupMode? _popupMode;

  void _handleMarkAulaClick() {
    setState(() {
      _popupMode = PopupMode.mark;
    });
  }

  void _handleUnmarkAulaClick() {
    setState(() {
      _popupMode = PopupMode.unmark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform(
          transform: Matrix4.skewX(-0.2),
          child: Text(
            'Aulas de Grupo',
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
                image: AssetImage('images/aulasGrupo.jpg'),
              ),
            ),
            const SizedBox(height: 35),
            const Text(
              'Aulas disponíveis',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<Aula>>(
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: _handleMarkAulaClick,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 133, 0, 0),
                    ),
                    child: const Text('Marcar aula'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: _handleUnmarkAulaClick,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 133, 0, 0),
                    ),
                    child: const Text('Desmarcar aula'),
                  ),
                ),
              ],
            ),
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

  Widget buildUser(Aula user) => ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 0, 60, 145),
          child: Text(DateFormat('dd').format(user.data)),
        ),
        title: Text(
          user.tipo,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          DateFormat('HH:mm').format(user.data),
          style: const TextStyle(color: Colors.white),
        ),
        trailing: user.isMarcada ? Icon(Icons.check) : Icon(Icons.close),
      );

  Widget _buildPopupContent() {
    if (_popupMode == PopupMode.mark) {
      return MarkAulaPopupContent();
    } else if (_popupMode == PopupMode.unmark) {
      return UnmarkAulaPopupContent();
    } else {
      return const SizedBox.shrink();
    }
  }
}
