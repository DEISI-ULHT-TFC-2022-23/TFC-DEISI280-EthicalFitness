import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalizedWorkoutsPage extends StatelessWidget {
  const PersonalizedWorkoutsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform(
          transform: Matrix4.skewX(
              -0.2), // skew the text by 0.3 radians (about 17 degrees)
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
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: const Image(
              image: AssetImage('images/treinoPersonalizado.jpg'),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement schedule classes functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 133, 0,
                        0), // sets the button's background color to red
                  ),
                  child: const Text('Marcar Treino'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement cancel classes functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 133, 0,
                        0), // sets the button's background color to red
                  ),
                  child: const Text('Desmarcar Treino'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
