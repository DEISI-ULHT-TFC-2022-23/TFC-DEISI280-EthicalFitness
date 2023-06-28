import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'video_player_widget.dart';

class DetailsTrainingPlan extends StatefulWidget {
  final int index;
  const DetailsTrainingPlan(this.index, {super.key});

  @override
  _DetailsTrainingPlanState createState() => _DetailsTrainingPlanState();
}

class _DetailsTrainingPlanState extends State<DetailsTrainingPlan> {
  final asset = 'assets/bmwTest.mp4';
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(asset)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;
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
        backgroundColor: const Color.fromARGB(255, 133, 0, 0),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Center(
        // Center the video vertically
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the video horizontally
          children: [
            VideoPlayerWidget(controller: controller),
            const SizedBox(height: 32),
            if (controller.value.isInitialized)
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color.fromARGB(255, 133, 0, 0),
                child: IconButton(
                  icon: Icon(
                    isMuted ? Icons.volume_mute_rounded : Icons.volume_up,
                    color: Colors.white,
                  ),
                  onPressed: () => controller.setVolume(isMuted ? 1 : 0),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
