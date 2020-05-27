import 'dart:io';

/**
 * 文件操作类
 */
class FileUtils{

  static void writeToFile() async{
    var path = "";
    var file = new File(path);
    try {
      bool isExists = await file.exists();
      if(!isExists){
        await file.create();
      }
      await file.writeAsString("");
    } catch (e, s) {
      print(s);
    }
  }

  static void readFromFile() async{
    var path = "";
    var file = new File(path);
    try {
      bool isExist = await file.exists();
      if (!isExist) {
        await file.create();
      }
      await file.readAsString();
    } catch (e, s) {
      print(s);
    }

  }
}