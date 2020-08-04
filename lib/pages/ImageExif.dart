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
  File _image;
  String str = '''
  I/flutter (10804): kafka: [key: Image Model (ASCII), value: AOSP on IA Emulator]
I/flutter (10804): kafka: [key: Image ImageWidth (Long), value: 960]
I/flutter (10804): kafka: [key: Image ImageLength (Long), value: 1280]
I/flutter (10804): kafka: [key: Image DateTime (ASCII), value: 2020:07:28 03:09:10]
I/flutter (10804): kafka: [key: Image Orientation (Short), value: Horizontal (normal)]
I/flutter (10804): kafka: [key: Image ExifOffset (Long), value: 157]
I/flutter (10804): kafka: [key: GPS GPSLatitudeRef (ASCII), value: N]
I/flutter (10804): kafka: [key: GPS GPSLatitude (Signed Ratio), value: [37, 25, 1919/100]]
I/flutter (10804): kafka: [key: GPS GPSLongitudeRef (ASCII), value: W]
I/flutter (10804): kafka: [key: GPS GPSLongitude (Signed Ratio), value: [122, 5, 12/5]]
I/flutter (10804): kafka: [key: GPS GPSAltitude (Ratio), value: 5]
I/flutter (10804): kafka: [key: GPS GPSTimeStamp (Ratio), value: [3, 9, 12]]
I/flutter (10804): kafka: [key: GPS GPSDate (ASCII), value: 2020:07:28]
I/flutter (10804): kafka: [key: Image GPSInfo (Long), value: 435]
I/flutter (10804): kafka: [key: Image Make (ASCII), value: Google]
I/flutter (10804): kafka: [key: EXIF FNumber (Ratio), value: 14/5]
I/flutter (10804): kafka: [key: EXIF ExposureTime (Ratio), value: 1/100]
I/flutter (10804): kafka: [key: EXIF SubSecTimeDigitized (ASCII), value: 801]
I/flutter (10804): kafka: [key: EXIF SubSecTimeOriginal (ASCII), value: 801]
I/flutter (10804): kafka: [key: EXIF SubSecTime (ASCII), value: 801]
I/flutter (10804): kafka: [key: EXIF FocalLength (Ratio), value: 5]
I/flutter (10804): kafka: [key: EXIF Flash (Short), value: Flash did not fire]
I/flutter (10804): kafka: [key: EXIF ISOSpeedRatings (Short), value: 100]
I/flutter (10804): kafka: [key: EXIF DateTimeDigitized (ASCII), value: 2020:07:28 03:09:10]
I/flutter (10804): kafka: [key: EXIF DateTimeOriginal (ASCII), value: 2020:07:28 03:09:10]
I/flutter (10804): kafka: [key: EXIF ExifImageLength (Long), value: 1280]
I/flutter (10804): kafka: [key: EXIF WhiteBalance (Short), value: Auto]
I/fl
  ''';

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
    setState(() {
      _image = image;
    });
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
