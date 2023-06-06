// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:music_app/consts/colors.dart';

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
  var datePlayedName;
  WeeklyReportScreen({super.key});

  Future<String> generatePdfReport(List<WeeklyReportData> weeklyReports) async {
    final pdf = pw.Document();

    // Generate a PDF report for each weekF
    for (int i = 0; i < weeklyReports.length; i++) {
      final weeklyReport = weeklyReports[i];

      // Add a title to the PDF report
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Weekly Report ${datePlayedName.toString()}',
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
            );
          },
        ),
      );

      // Add the played songs to the PDF report
      for (int j = 0; j < weeklyReport.playedSongs.length; j++) {
        final song = weeklyReport.playedSongs[j];
        final datePlayed = weeklyReport.playedDate[j];
        datePlayedName = datePlayed;

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                children: [
                  pw.Text('Song: ${song.title}'),
                  pw.Text('Artist: ${song.artist}'),
                  pw.Text('Date Played: $datePlayed'),
                  pw.SizedBox(height: 10),
                ],
              );
            },
          ),
        );
      }
    }

    // Save the PDF report to a file
    final outputDir = await getExternalStorageDirectory();
    final outputFile = File('${outputDir!.path}/${datePlayedName.toString()}.pdf');
    await outputFile.writeAsBytes(await pdf.save());

    return outputFile.path;
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
      appBar: AppBar(
        actions: [
            controller.playedSongs.isNotEmpty && controller.playedDate.isNotEmpty ? IconButton(onPressed: () async{
            final weeklyReportData = WeeklyReportData(
                playedSongs: controller.playedSongs.toList(),
                playedDate: controller.playedDate.map<DateTime>((dynamic date) => date as DateTime).toList(),
              );
              // Generate the PDF report
              final filePath = await generatePdfReport([weeklyReportData]);
              viewPdfReport(filePath);
          }, icon: const Icon(Icons.picture_as_pdf_sharp, color: buttonColor,)) : const Text(""),
        ],
        title: const Text('Weekly Report '),
      ),
      body: controller.playedSongs.isNotEmpty && controller.playedDate.isNotEmpty
          ? ListView.builder(
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
                 const Center(child:  Text("Empty File, No Song Is Played Yet Today!", style: TextStyle(color: whiteColor),),),
                 IconButton(onPressed: (){
                  openFile();
                 }, icon: const Icon(Icons.file_open, color: buttonColor,))
              ],
            )
    );
  }
}