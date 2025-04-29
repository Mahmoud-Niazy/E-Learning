import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ConvertUrlIntoXFileForCourseUseCase {

  Future<XFile?>execute(String url)async{
    final dio =  Dio();
    final directory = await getTemporaryDirectory();
    String fileName = 'media_${DateTime.now().millisecondsSinceEpoch}';
    if (url.toLowerCase().contains('.mp4') ||
        url.toLowerCase().contains('.mov') ||
        url.toLowerCase().contains('.avi')) {
      fileName += '.mp4';
    } else if (url.toLowerCase().contains('.jpg') ||
        url.toLowerCase().contains('.jpeg')) {
      fileName += '.jpg';
    } else if (url.toLowerCase().contains('.png')) {
      fileName += '.png';
    } else {
      fileName += '.tmp';
    }
    final filePath = '${directory.path}/$fileName';
      await dio.download(
        url,
        filePath,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
      if (!await File(filePath).exists()) {
    throw Exception('Downloaded file not found');
    }
    return XFile(filePath);
  }

}