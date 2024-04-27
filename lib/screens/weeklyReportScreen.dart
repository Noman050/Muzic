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

    const maxSongsPerPage = 10; // Maximum number of songs per page

    // Generate a PDF report for each week
    for (int i = 0; i < weeklyReports.length; i++) {
      final weeklyReport = weeklyReports[i];
      final songCount = weeklyReport.playedSongs.length;

      // Add a title to the PDF report
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Weekly Report Of Songs Played By You: \n${datePlayedName.toString()}',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            );
          },
        ),
      );

      // Add the played songs to the PDF report
      for (int j = 0; j < songCount; j += maxSongsPerPage) {
        final songsSubset = weeklyReport.playedSongs.sublist(j,
            j + maxSongsPerPage < songCount ? j + maxSongsPerPage : songCount);
        final datesSubset = weeklyReport.playedDate.sublist(j,
            j + maxSongsPerPage < songCount ? j + maxSongsPerPage : songCount);

        final tableData = <List<String>>[
          ['Song Title', 'Date Played'],
          for (int k = 0; k < songsSubset.length; k++)
            [
              songsSubset[k].title,
              // songsSubset[k].artist.toString(),
              datePlayedName =
                  datesSubset[k].toString(), // Convert DateTime to string
            ],
        ];

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Table.fromTextArray(
                    context: context,
                    headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    cellAlignment: pw.Alignment.centerLeft,
                    headerAlignment: pw.Alignment.centerLeft,
                    cellStyle: const pw.TextStyle(),
                    data: tableData,
                  ),
                ],
              );
            },
          ),
        );
      }
    }

    // Save the PDF report to a file
    final outputDir = await getExternalStorageDirectory();
    final outputFile = File(
        '${outputDir!.path}/${datePlayedName.toString()}.pdf'); //using device storage
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
      initialDirectory:
          '/data/user/0/com.example.music_app/app_flutter/', //using device storage
      type: FileType.any,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            controller.playedSongs.isNotEmpty &&
                    controller.playedDate.isNotEmpty
                ? IconButton(
                    onPressed: () async {
                      final weeklyReportData = WeeklyReportData(
                        playedSongs: controller.playedSongs.toList(),
                        playedDate: controller.playedDate
                            .map<DateTime>((dynamic date) => date as DateTime)
                            .toList(),
                      );
                      // Generate the PDF report
                      final filePath =
                          await generatePdfReport([weeklyReportData]);
                      viewPdfReport(filePath);
                    },
                    icon: const Icon(
                      Icons.picture_as_pdf_sharp,
                      color: buttonColor,
                    ))
                : const Text(""),
          ],
          title: const Text('Weekly Report'),
        ),
        body: controller.playedSongs.isNotEmpty &&
                controller.playedDate.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
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
                        textColor: whiteColor,
                        title: Text(
                          song.title,
                          style: const TextStyle(color: whiteColor),
                        ),
                        // subtitle: Text(
                        //   song.artist.toString(),
                        //   style: const TextStyle(color: whiteColor),
                        // ),
                        subtitle: Text(
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
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Empty File, No Song Is Played Yet Today!",
                      style: TextStyle(color: whiteColor),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        openFile();
                      },
                      icon: const Icon(
                        Icons.file_open,
                        color: buttonColor,
                      ))
                ],
              ));
  }
}
