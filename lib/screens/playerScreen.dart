// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_app/consts/colors.dart';
import 'package:music_app/consts/myTextStyle.dart';
import 'package:music_app/controllers/playerController.dart';

class PlayerScreen extends StatelessWidget {
  final List<SongModel> data;
  const PlayerScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: data[controller.playIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: const Icon(
                      Icons.music_note,
                      size: 48,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12,),

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
                        data[controller.playIndex.value].displayNameWOExt.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: myStyle(color: bgDarkColor, family: bold, size: 24),
                      ),

                      const SizedBox(height: 12,),

                      Text(
                        data[controller.playIndex.value].artist.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: myStyle(color: bgDarkColor, family: regular, size: 20),
                      ),

                      const SizedBox(height: 12,),

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

                      const SizedBox(height: 12,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                           IconButton(
                            onPressed: controller.toggleRepeat,
                            icon: Icon(
                              controller.isRepeat.value
                                  ? Icons.repeat_one_rounded
                                  : Icons.repeat_rounded,
                              size: 38,
                              color: blackColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (controller.playIndex.value > 0) {
                                controller.playSong(
                                  data[controller.playIndex.value - 1].uri,
                                  controller.playIndex.value - 1,
                                  data,
                                );
                              } else {
                                controller.playIndex.value = 0;
                                controller.playSong(data[0].uri, 0, data);
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
                              if (controller.playIndex.value < data.length - 1) {
                                controller.playSong(
                                  data[controller.playIndex.value + 1].uri,
                                  controller.playIndex.value + 1,
                                  data,
                                );
                              } else {
                                controller.playIndex.value = 0;
                                controller.playSong(data[0].uri, 0, data);
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
                               controller.isShuffle.value
                                  ? Icons.shuffle_rounded
                                  : Icons.shuffle_outlined,
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