import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_app/consts/colors.dart';
import 'package:music_app/consts/myTextStyle.dart';
import 'package:music_app/controllers/playerController.dart';

class PlayerScreen extends StatefulWidget {
  final List<SongModel> data;

  const PlayerScreen({Key? key, required this.data}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> with SingleTickerProviderStateMixin {
  final PlayerController controller = Get.find<PlayerController>();
  late final AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Now Playing")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
                  child:  QueryArtworkWidget(
                    id: 0,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: Container(
                      decoration: const BoxDecoration(color: buttonColor ,borderRadius: BorderRadius.all(Radius.circular(200))),
                      child: const Icon(
                        Icons.music_note_rounded,
                        size: 300,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12, 
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        widget.data[controller.playIndex.value].displayNameWOExt.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: myStyle(color: bgDarkColor, family: bold, size: 24),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.data[controller.playIndex.value].artist.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: myStyle(color: bgDarkColor, family: regular, size: 20),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            controller.position.value,
                            style: myStyle(color: bgDarkColor),
                          ),
                          Expanded(
                            child: Slider(
                              thumbColor: blackColor,
                              activeColor: buttonColor,
                              inactiveColor: bgColor,
                              min: const Duration(seconds: 0).inSeconds.toDouble(),
                              max: controller.max.value,
                              value: controller.value.value,
                              onChanged: (newValue) {
                                // Calculate the maximum allowed value
                                final maxAllowedValue = controller.max.value - 1.0;
                                // Check if the new value exceeds the maximum allowed value
                                if (newValue > maxAllowedValue) {
                                // If exceeded, set the value to the maximum allowed value
                                newValue = maxAllowedValue;
                                }
                                // Update the value in the controller
                                controller.changeDurationToSeconds(newValue.toInt());
                                newValue = newValue;
                              },
                            ),
                          ),
                          Text(
                            controller.duration.value,
                            style: myStyle(color: bgDarkColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: controller.toggleRepeat,
                            icon: Icon(
                              controller.isRepeat.value ? Icons.repeat_one_rounded : Icons.repeat_rounded,
                              size: 38,
                              color: blackColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (controller.playIndex.value > 0) {
                                controller.playSong(
                                  widget.data[controller.playIndex.value - 1].uri,
                                  controller.playIndex.value - 1,
                                  widget.data,
                                );
                              } else {
                                controller.playIndex.value = 0;
                                controller.playSong(widget.data[0].uri, 0, widget.data);
                              }
                            },
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              size: 40,
                              color: blackColor,
                            ),
                          ),
                          Obx(
                            () => CircleAvatar(
                              radius: 35,
                              backgroundColor: bgDarkColor,
                              child: Transform.scale(
                                scale: 2.5,
                                child: IconButton(
                                  onPressed: () {
                                    if (controller.isPlaying.value) {
                                      controller.audioPlayer.pause();
                                      controller.isPlaying(false);
                                    } else {
                                      controller.audioPlayer.play();
                                      controller.isPlaying(true);
                                    }
                                  },
                                  icon: controller.isPlaying.value
                                      ? const Icon(Icons.pause, color: buttonColor)
                                      : const Icon(Icons.play_arrow_rounded, color: buttonColor),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (controller.playIndex.value < widget.data.length - 1) {
                                controller.playSong(
                                  widget.data[controller.playIndex.value + 1].uri,
                                  controller.playIndex.value + 1,
                                  widget.data,
                                );
                              } else {
                                controller.playIndex.value = 0;
                                controller.playSong(widget.data[0].uri, 0, widget.data);
                              }
                            },
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              size: 40,
                              color: blackColor,
                            ),
                          ),
                          IconButton(
                            onPressed: controller.toggleShuffle,
                            icon: Icon(
                              controller.isShuffle.value ? Icons.shuffle_rounded : Icons.shuffle_outlined,
                              size: 38,
                              color: controller.isRepeat.value ? blackColor : controller.isShuffle.value ? buttonColor : blackColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
