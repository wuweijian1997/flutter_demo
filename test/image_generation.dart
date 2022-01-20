import 'dart:io';

import 'package:flutter/foundation.dart';

void main() {
  Directory assetDir = Directory('./assets');



  StringBuffer result = StringBuffer();
  result.write('/// generate by run projectRoot/test/asset_generate.dart ');
  result.write('\n\n');
  result.write('class Assets {\n');

  List<String> nameList = [];
  generate(assetDir, result, nameList);
  result.write('\n}');
  if (kDebugMode) {
    print(result);
  }


  File file = File('./lib/util/assets_util.dart');
  if (!file.existsSync()) file.createSync();
  file.writeAsString(result.toString());


}

generate(Directory directory, StringBuffer result, List<String> nameList) {
  List<FileSystemEntity> dirOrFileList = directory.listSync();
  dirOrFileList.sort((file1, fil12) {
    if(file1 is File) {
      return -1;
    }
    return 1;
  });
  if (kDebugMode) {
    print(directory.path + "========");
  }
  if (dirOrFileList.isNotEmpty) result.write('\n\n\t///${directory.path.replaceAll("\\", "/")}\n');
  for(FileSystemEntity dirOrFile in dirOrFileList) {
    if (dirOrFile is File) {
      //Windows下文件路径是 ./assets\image\chat\*.png
      List<String> splitList = dirOrFile.path.split(RegExp(r'[/,\\]'));
      String fileName = splitList.last.split('.').first;
      fileName = fileName.replaceAll('-', '_');

      if (fileName.isNotEmpty && !dirOrFile.path.contains('DS_Store') && !nameList.contains(fileName)) {
        result.write('\tstatic const $fileName = \'${dirOrFile.path.replaceAll('\\', '/')}\';\n');
        nameList.add(fileName);
      }
    } else if (dirOrFile is Directory) {
      generate(dirOrFile, result, nameList);
    }
  }

}