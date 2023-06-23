import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToFirstNews();
    });
  }

  void scrollToFirstNews() {
    Timer(const Duration(seconds: 2), () {
      _scrollController.animateTo(
        720,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, "/login", (route) => false);
          },
        ),
        title: const Text(''),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/homePage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView.builder(
              controller: _scrollController,
              itemCount: 7, // Atualizado para exibir 7 notícias (2 adicionadas)
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SizedBox(height: MediaQuery.of(context).size.height);
                }
                if (index == 1) {
                  // Primeira notícia
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(16.0),
                        child: const Text(
                          'Posts',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 242, 242, 242),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        color: const Color.fromARGB(
                            255, 0, 28, 51), // Cor da primeira notícia
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Título da segunda notícia',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Descrição da segunda notícia',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                if (index == 2) {
                  // Primeira notícia
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: const Color.fromARGB(
                        255, 136, 136, 136), // Cor da primeira notícia
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Título da segunda notícia',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Descrição da segunda notícia',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (index == 3) {
                  // Segunda notícia
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: const Color.fromARGB(
                        255, 0, 28, 51), // Cor da segunda notícia
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Título da terceira notícia',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Descrição da terceira notícia',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (index == 4) {
                  // Primeira notícia
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: const Color.fromARGB(
                        255, 136, 136, 136), // Cor da primeira notícia
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Título da quarta notícia',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Descrição da quarta notícia',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scrollToFirstNews,
        backgroundColor: const Color.fromARGB(255, 133, 0, 0),
        child: const Icon(Icons.arrow_downward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
