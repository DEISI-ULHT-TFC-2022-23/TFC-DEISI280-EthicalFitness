import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final asset = 'assets/bmwTest.mp4';
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  bool _showFloatingButton = true;

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel(); // Cancelar o timer ao sair da tela
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
    _timer = Timer(const Duration(seconds: 1), () {
      setState(() {
        _showFloatingButton = false;
      });
    });

    _scrollController.animateTo(
      20,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _resetTimer() {
    _timer?.cancel(); // Cancelar o timer atual
    _timer = Timer(const Duration(seconds: 1), () {
      setState(() {
        _showFloatingButton = false;
      });
    });
  }

  void _showFloatingButtonOnTap() {
    setState(() {
      _showFloatingButton = true;
    });
    _resetTimer();
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
      body: GestureDetector(
        onTap: _showFloatingButtonOnTap,
        child: Stack(
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
                  // Título "Posts"
                  return AnimatedContainer(
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
                  );
                }
                if (index == 1) {
                  // Primeira notícia
                  return Container(
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
                  );
                }
                if (index == 2) {
                  // Vídeo
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.black, // Cor de fundo do vídeo
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const VideoPlayerWidget(
                      videoAsset:
                          'assets/bmwTest.mp4', // Caminho do vídeo local
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
                return Container(); // Retornar um container vazio por padrão
              },
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoAsset;

  const VideoPlayerWidget({required this.videoAsset, Key? key})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    final videoPlayerController =
        VideoPlayerController.asset(widget.videoAsset);

    await videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController != null &&
        _chewieController.videoPlayerController.value.isInitialized) {
      return Chewie(
        controller: _chewieController,
      );
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
