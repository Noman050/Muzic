// ignore_for_file: unrelated_type_equality_checks, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/Models/myRoute.dart';
import 'package:music_app/controllers/playerController.dart';
import 'package:music_app/screens/playListScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../consts/myTextStyle.dart';
import '../widgets/songSeachDelegate.dart';
import './playerScreen.dart';
import '../widgets/myDrawer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    
    var controller = Get.put(PlayerController());
    late AsyncSnapshot<List<SongModel>> dataForSearch;
    return  Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
            showSearch(
                context: context,
                delegate: SongSearchDelegate(data: dataForSearch.data as List<SongModel>),
              );
          }, icon: const Icon(Icons.search , color: buttonColor,)),
        ],
        title: const Text("Music Listening App" , style: TextStyle(fontSize: 18, letterSpacing: 1),),
      ),
      body: 
        FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
            ignoreCase: true, 
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null, 
            uriType: UriType.EXTERNAL,
          ),
      builder: (context, snapshot){
        if(snapshot.data==null){
          return const Center(child: CircularProgressIndicator());
        }
        else if(snapshot.data!.isEmpty){
          return Center(child: Text("No Song Found", style: myStyle(),),);
        }
        else{
          dataForSearch=snapshot;
          return
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 4),
             child: Obx( ()=>
               ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                tileColor: bgColor,
                title: Text(snapshot.data![index].displayNameWOExt, style: myStyle(family: bold, size: 15,),),
                subtitle: Text("${snapshot.data![index].artist}", style: myStyle(family: regular, size: 12),),
                leading: QueryArtworkWidget(id: snapshot.data![index].id, type: ArtworkType.AUDIO, nullArtworkWidget: const Icon(Icons.music_note, color: whiteColor, size: 32,),),
                trailing:(controller.playIndex==index) && (controller.isPlaying.value) ? const Icon(Icons.pause, color: whiteColor, size: 26,): const Icon(Icons.play_arrow, color: whiteColor, size: 26,),
                onTap: (){
                  Get.to(()=> PlayerScreen(data: snapshot.data!), 
                  transition: Transition.downToUp);
                  controller.playSong(snapshot.data![index].uri, index, snapshot.data as List<SongModel>);
                },
              ),
             ),
            );
            },
            ),
            );
          }
      },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bgColor,
        selectedItemColor: buttonColor,
        unselectedItemColor: whiteColor,
        items: const [
           BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Player',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.queue_music),
            label: 'Playlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
              //  builder: (context) => PlaylistScreen(data: dataForSearch.data as List<SongModel>),
                 builder: (context) =>  PlaylistScreen(data: dataForSearch.data as List<SongModel>),
              ),
            );
          }
          else if(index==2){
            const MyDrawer();
             Navigator.of(context).pushNamed(MyRoute.settingsScreem);            
          }
        },
    )
    );
  }
}

