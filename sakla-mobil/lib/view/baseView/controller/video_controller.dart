import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class VideoController extends GetxController {
  File? fileVideo;
  Uint8List? thumbnailBytes;

  var videoSizes = 0.obs;
  get videoSize => videoSizes.value;
  set videoSize(value) => videoSizes.value = value;

  Future pickVideo() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getVideo(source: ImageSource.gallery);

    if (pickedFile == null) return;
    final file = File(pickedFile.path);
    fileVideo = file;
    await generateThumbnail(file);
    await getVideoSize(file);
  }

  Future generateThumbnail(File file) async {
    final thumbNailBytesa = await VideoCompress.getByteThumbnail(file.path);
    thumbnailBytes = thumbNailBytesa;
  }

  Future getVideoSize(File file) async {
    final size = await file.length();
    videoSize = size;
  }
}
