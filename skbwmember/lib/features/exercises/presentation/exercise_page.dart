import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwmember/components/title_card.dart';
import 'package:skbwmember/features/exercises/domain/entities/exercise.dart';
import 'package:skbwmember/theme/app_font.dart';
import 'package:video_player/video_player.dart';

class ExercisePage extends StatefulWidget {
  final Exercise exercise;
  const ExercisePage({super.key, required this.exercise});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late VideoPlayerController controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.exercise.videoPath)
      ..initialize().then((_) async {
        await controller.setLooping(true);
        await controller.play();
        setState(() {
          isPlaying = true;
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void playPause() async {
    if (controller.value.isPlaying) {
      await controller.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await controller.play();
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
        title: const Text(
          'Exercise',
          style: TextStyle(
            fontSize: 20,
            fontFamily: AppFont.primaryFont,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TitleCard(
                title: 'Exercise Video',
                children: [
                  controller.value.isInitialized
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: VideoPlayer(controller),
                          ),
                        )
                      : LoadingAnimationWidget.staggeredDotsWave(
                          color: theme.primary,
                          size: 50,
                        ),
                ],
              ),
              SizedBox(height: 10),
              TitleCard(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.exercise.name,
                        style: TextStyle(
                          fontFamily: AppFont.logoFont,
                          fontSize: 22,
                        ),
                      ),
                      IconButton(
                        color: theme.onPrimary,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(theme.primary),
                        ),
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                        onPressed: playPause,
                      ),
                    ],
                  ),
                  Divider(color: theme.onSurface.withAlpha(100)),
                  Text(
                    widget.exercise.description,
                    style: TextStyle(
                      fontFamily: AppFont.secondaryFont,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
