import 'dart:io';

main() {
  Directory assetDir = Directory('./lib/pages');

  StringBuffer result = new StringBuffer();
  result.write('\n\n');
  result.write('class Codes {\n');

  List<String> nameList = [];
  generate(assetDir, result, nameList);
  result.write('\n}');
  print(result);

  File file = new File('./lib/const/codes.dart');
  if (!file.existsSync()) file.createSync();
  file.writeAsString(result.toString());
}

generate(Directory directory, StringBuffer result, List<String> nameList) {
  List<FileSystemEntity> dirOrFileList = directory.listSync();
  dirOrFileList.sort((file1, fil12) {
    if (file1 is File) {
      return -1;
    }
    return 1;
  });
  if (dirOrFileList.isNotEmpty) result.write(generatePath(directory.path));
  for (FileSystemEntity dirOrFile in dirOrFileList) {
    if (dirOrFile is File) {
      //Windows下文件路径是 ./assets\image\chat\*.png
      List<String> splitList = dirOrFile.path.split(new RegExp(r'[/,\\]'));
      String fileName = splitList.last.split('.').first;
      fileName = fileName.replaceAll('-', '_');

      if (fileName.isNotEmpty &&
          !dirOrFile.path.contains('DS_Store') &&
          !nameList.contains(fileName) &&
          dirOrFile.path.contains('_page')) {
        result.write(generatePath(dirOrFile.path));
        String code = dirOrFile.readAsStringSync().replaceAll('\$', '\\\$');
        result.write('\tstatic const ${fileName.toUpperCase()} = \'\'\'\n$code\'\'\';\n');
        nameList.add(fileName);
      }
    } else if (dirOrFile is Directory) {
      generate(dirOrFile, result, nameList);
    }
  }
}

generatePath(String path) {
  return '\n\t///\t${path.replaceAll("\\", "/").split("./").last}\n';
}
