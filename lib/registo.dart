import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Registo extends StatefulWidget {
  final VoidCallback showLoginPage;
  const Registo({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<Registo> createState() => _RegistoState();
}

class _RegistoState extends State<Registo> {
  // Controladores de texto
  final _nomeControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _passwordControler = TextEditingController();
  final _confirmPasswordControler = TextEditingController();

  // Gestão de memória
  @override
  void dispose() {
    _nomeControler.dispose();
    _emailControler.dispose();
    _passwordControler.dispose();
    _confirmPasswordControler.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        // Cria o utilizador no Firebase Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailControler.text.trim(),
          password: _passwordControler.text.trim(),
        );

        // Obtém o ID do utilizador criado
        String userId = userCredential.user!.uid;

        // Armazena o nome do utilizador no Cloud Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'nome': _nomeControler.text.trim(),
        });

        // O registo foi concluído com sucesso
      } catch (e) {
        // Ocorreu um erro durante o registo
        print('Erro no registo: $e');
      }
    }
  }

  bool passwordConfirmed() {
    if (_passwordControler.text.trim() ==
        _confirmPasswordControler.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(
                  image: AssetImage('images/EthicalFitnessSimbolo.png'),
                  height: 260,
                  width: 280,
                ),
                Text(
                  'Olá! Ainda não tens conta?',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Regista-te já!',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nome',
                        ),
                        controller: _nomeControler,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                        controller: _emailControler,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                        controller: _passwordControler,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Confirmar password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                        ),
                        controller: _confirmPasswordControler,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 143, 0, 0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Registar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Já tens conta?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        ' Entrar agora',
                        style: TextStyle(
                          color: Color.fromARGB(255, 12, 125, 181),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
