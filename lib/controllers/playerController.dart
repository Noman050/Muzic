import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController{

  final audioQuery= OnAudioQuery();
  final audioPlayer= AudioPlayer();

  var playIndex=0.obs;
  var isPlaying=false.obs;

  var duration =''.obs;
  var position = ''.obs;

  var max=0.0.obs;
  var value=0.0.obs;

  updatePosition(List<SongModel> data){
    audioPlayer.durationStream.listen((d) {
      duration.value=d.toString().split(".")[0];
      max.value=d!.inSeconds.toDouble();
     });
     audioPlayer.positionStream.listen((p) {
      position.value=p.toString().split(".")[0];
      value.value=p.inSeconds.toDouble();

      if (value.value >= max.value) {
      audioPlayer.stop();
      isPlaying(false);
      // Play the next song if available
      if (playIndex.value < data.length - 1) {
        playSong(data[playIndex.value + 1].uri, playIndex.value + 1, data);
      }
      }
     });
     
  }

  @override
  void onInit() {
    checkPermissions();
    super.onInit();
  }
  changeDurationToSeconds(seconds){
    var duration =Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  playSong(String? uri,int index, List<SongModel> data) async{
    playIndex.value=index;
    isPlaying.value=true;
    try{
      await audioPlayer.stop();
      audioPlayer.setAudioSource(
      AudioSource.uri(Uri.parse(uri!),
      
    ),);
    await audioPlayer.play();
    isPlaying(true);
    updatePosition(data);
    }
    on Exception catch(e){
      e.obs;
    }
  }

  checkPermissions() async{
    var perm = await Permission.storage.request();
    if(perm.isGranted){
    }else{
      checkPermissions();
    }
  }
}