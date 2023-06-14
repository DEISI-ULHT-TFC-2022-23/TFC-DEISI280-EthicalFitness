import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'video_player_widget.dart';

class DetailsTrainingPlan extends StatefulWidget {
  final int index;
  const DetailsTrainingPlan(this.index);

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
    return Column(
      children: [
        VideoPlayerWidget(controller: controller),
        const SizedBox(height: 32),
        if (controller != null && controller.value.isInitialized)
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.red,
            child: IconButton(
              icon: Icon(
                isMuted ? Icons.volume_mute : Icons.volume_up,
                color: Colors.white,
              ),
              onPressed: () => controller.setVolume(isMuted ? 1 : 0),
            ),
          ),
      ],
    );
  }
}
