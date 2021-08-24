import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import '../../../core/components/app_bar_container.dart';

class VideoCompressView extends StatefulWidget {
  @override
  _VideoCompressViewState createState() => _VideoCompressViewState();
}

class _VideoCompressViewState extends State<VideoCompressView> {
  File? fileVideo;
  Uint8List? thumbnailBytes;
  int? videoSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildAppBar(),
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.all(context.height * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    fileVideo != null
                        ? Column(
                            children: [
                              buildThumbnail(),
                              const SizedBox(
                                height: 16,
                              ),
                              buildVideoSize(),
                              const SizedBox(
                                height: 16,
                              ),
                              buildCompressVideoButton(context)
                            ],
                          )
                        : buildPickedVideoButton(context),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget buildPickedVideoButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        pickVideo();
      },
      child: Ink(
        width: context.width / 1.1,
        height: context.height / 16,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff3B4183), Color(0xff515AB6)]),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          color: Color(0xffED7917),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text('Pick Video',
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ),
      ),
    );
  }

  Widget buildCompressVideoButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {},
      child: Ink(
        width: context.width / 1.1,
        height: context.height / 16,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff3B4183), Color(0xff515AB6)]),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          color: Color(0xffED7917),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text('Compress Video',
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Expanded(
      flex: 1,
      child: AppBarContainer(
        child: Center(
          child: Text(
            'Video Cormpress',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }

  Future pickVideo() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getVideo(source: ImageSource.gallery);

    if (pickedFile == null) return;
    final file = File(pickedFile.path);
    setState(() {
      fileVideo = file;
    });
    await generateThumbnail(fileVideo!);
    await getVideoSize(fileVideo!);
  }

  Future generateThumbnail(File file) async {
    final thumbNailBytesa = await VideoCompress.getByteThumbnail(file.path);
    setState(() => thumbnailBytes = thumbNailBytesa);
  }

  Future getVideoSize(File file) async {
    final size = await file.length();
    setState(() {
      videoSize = size;
    });
  }

  Widget buildThumbnail() {
    return thumbnailBytes == null
        ? CircularProgressIndicator()
        : Image.memory(
            thumbnailBytes!,
            height: 100,
          );
  }

  Widget buildVideoSize() {
    if (fileVideo == null) return Container();
    final size = videoSize! / 1000;
    return Column(
      children: [
        Text('Orginal Video Info',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Size: $size KB',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Future compressVideo() async {}
}
