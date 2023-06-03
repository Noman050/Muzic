import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/consts/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import '../controllers/playerController.dart';

class WeeklyReportData {
  final List<SongModel> playedSongs;
  final List<DateTime> playedDate;

  WeeklyReportData({
    required this.playedSongs,
    required this.playedDate,
  });
}

class WeeklyReportScreen extends StatelessWidget {
  final PlayerController controller = Get.find();

  WeeklyReportScreen({super.key});

  Future<String> generatePdfReport(List<WeeklyReportData> weeklyReports) async {
    final directory = await getApplicationDocumentsDirectory();
    final outputDir = directory.path;
    final List<String> fileNames = [];

    // Generate a PDF report for each week
    for (int i = 0; i < weeklyReports.length; i++) {
      final weeklyReport = weeklyReports[i];
      final firstDayOfWeek = weeklyReport.playedDate.first;
      final pdf = pw.Document();

      // Add a title to the PDF report
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Weekly Report ${i + 1}',
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
            );
          },
        ),
      );

      // Add the played songs to the PDF report
      final List<pw.Widget> songWidgets = [];
      for (int j = 0; j < weeklyReport.playedSongs.length; j++) {
        final song = weeklyReport.playedSongs[j];
        final datePlayed = weeklyReport.playedDate[j];

        songWidgets.add(
          pw.Column(
            children: [
              pw.Text('Song: ${song.title}'),
              pw.Text('Artist: ${song.artist}'),
              pw.Text('Date Played: $datePlayed'),
              pw.SizedBox(height: 10),
            ],
          ),
        );
      }
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.ListView(children: songWidgets);
          },
        ),
      );

      // Save the PDF report to a file
      final outputFile = File('$outputDir/weekly_report_$firstDayOfWeek.pdf');
      await outputFile.writeAsBytes(await pdf.save());
      fileNames.add(outputFile.path);
    }

    return fileNames.join(',');
  }

  void viewPdfReport(String filePath) {
    if (filePath.isNotEmpty) {
      OpenFile.open(filePath);
    }
  }
  Future<void> openFile() async {
    await FilePicker.platform.pickFiles(
      initialDirectory: '/data/user/0/com.example.music_app/app_flutter/',
      type: FileType.any,
    );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        actions: [
          controller.playedSongs.isNotEmpty && controller.playedDate.isNotEmpty ? IconButton(onPressed: () async{
            final weeklyReportData = WeeklyReportData(
                    playedSongs: controller.playedSongs.toList(),
                    playedDate: controller.playedDate.map<DateTime>((dynamic date) => date as DateTime).toList(),
                  );

                  // Generate the PDF report
                  final filePaths = await generatePdfReport([weeklyReportData]);
                  final fileNames = filePaths.split(',');
                  if (fileNames.isNotEmpty) {
                    for (final fileName in fileNames) {
                      viewPdfReport(fileName);
                    }
                  }
          }, icon: const Icon(Icons.view_array, color: buttonColor,),
          ) : const Text(""),
        ],
        backgroundColor: bgColor,
        title: const Text('Weekly Report'),
      ),
      body:
            controller.playedSongs.isNotEmpty && controller.playedDate.isNotEmpty ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.playedSongs.length,
              itemBuilder: (context, index) {
                final song = controller.playedSongs[index];
                final datePlayed = controller.playedDate[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: bgColor,
                    title: Text(
                      song.title,
                      style: const TextStyle(color: whiteColor),
                    ),
                    subtitle: Text(
                      song.artist.toString(),
                      style: const TextStyle(color: whiteColor),
                    ),
                    trailing: Text(
                      datePlayed.toString(),
                      style: const TextStyle(color: whiteColor),
                    ),
                    leading: QueryArtworkWidget(
                      id: song.id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: const Icon(
                        Icons.music_note,
                        color: whiteColor,
                        size: 32,
                      ),
                    ),
                  ),
                );
              },
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                 const Center(child:  Text("Empty File, No Song is played yet !", style: TextStyle(color: whiteColor),),),
                 IconButton(onPressed: (){
                  openFile();
                 }, icon: const Icon(Icons.file_open, color: buttonColor,))
              ],
            )
            
    );
    
  }
}
