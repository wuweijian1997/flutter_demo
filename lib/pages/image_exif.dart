import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageExifPage extends StatefulWidget {
  static const rName = 'ImageExifPage';

  @override
  _ImageExifPageState createState() => _ImageExifPageState();
}

class _ImageExifPageState extends State<ImageExifPage> {

  printExifOf(String path) async {
    Map<String, IfdTag> data =
        await readExifFromBytes(await new File(path).readAsBytes());
    if (data == null || data.isEmpty) {
      print("kafka No EXIF information found\n");
      return;
    }
    data.forEach((key, value) {
      print('kafka: [key: $key, '
          'tagType: ${value.tagType}, '
          'value:${value.printable}, '
          'runtimeType: ${value.printable.runtimeType}, ');
    });
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    printExifOf(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EXIF Viewer Example'),
      ),
      body: Column(children: <Widget>[
        GestureDetector(
          onTap: getImage,
          child: Text('选择图片'),
        )
      ]),
    );
  }
}
