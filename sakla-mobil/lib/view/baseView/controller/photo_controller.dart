import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

class PhotoController extends GetxController {
  Future uploadFile(String path) async {
    var postUri = Uri.parse(
        'https://expers-68-market-back-end.herokuapp.com/api/v1/createNewUserSakla');

    var request = await http.post(postUri, body: {
      'name_surname': '$path',
      'email': 'dasd@asda.dasdsa',
      'password': 'path',
    });
    print(request.body);
    print(request.statusCode);
  }

  Future selectImage() async {
    var image = ImagePicker();
    var selectedFile = await image.getImage(source: ImageSource.gallery);
    var imageFile = File(selectedFile!.path);
    List<int> imageBytes = imageFile.readAsBytesSync();
    var base64Image = base64Encode(imageBytes);

    var postUri = Uri.parse('a');
    print(base64Image.length);
    var request = await http.post(postUri, body: {});
    print(request.body);
    print(request.statusCode);
  }
}
