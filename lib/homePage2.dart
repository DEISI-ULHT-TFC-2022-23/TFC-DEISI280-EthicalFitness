import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child("files/");
      final listResult = await storageRef.listAll();

      List<String> urls = [];
      for (var item in listResult.items) {
        final url = await item.getDownloadURL();
        urls.add(url);
      }

      setState(() {
        imageUrls.addAll(urls);
      });
    } catch (error) {
      print('Erro ao buscar as imagens: $error');
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState(() {
      uploadTask = null;
    });
  }

  Future<void> deleteImage(int index) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child("files/");
      final listResult = await storageRef.listAll();

      if (index < 0 || index >= listResult.items.length) {
        // Exibir mensagem de erro ou retornar, pois o índice é inválido
        return;
      }

      final item = listResult.items[index];
      await item.delete();

      setState(() {
        imageUrls.removeAt(index);
      });

      print('Imagem apagada com sucesso!');
    } catch (error) {
      print('Erro ao apagar a imagem: $error');
    }
  }

  void showPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alterar Posts'),
          content: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Definindo a cor vermelha
                  ),
                  onPressed: selectFile,
                  child: const Text('Selecionar ficheiro'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Definindo a cor vermelha
                  ),
                  onPressed: uploadFile,
                  child: const Text('Carregar Ficheiro'),
                ),
              ],
            ),
          ),
        );
      },
    );
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/homePage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (pickedFile != null)
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 133, 0, 0),
                    child: Center(
                      child: Image.file(
                        File(pickedFile!.path!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(imageUrls[index]),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          deleteImage(index);
                        }
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: Image.network(imageUrls[index]),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              buildProgress(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showPopUp,
        backgroundColor:
            const Color.fromARGB(255, 133, 0, 0), // Definindo a cor vermelha
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;

            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(height: 50);
          }
        },
      );
}
