import 'dart:developer';
import 'dart:io';

import 'package:braille_recognition/config.dart';
import 'package:braille_recognition/multipart_requset.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class Translator{
  static Map<String, String> headers = {
    "User-Agent":
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36",
    "Accept":
        "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
    "Accept-Encoding": "gzip, deflate, br",
    "Accept-Language": "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7",
    "Cache-Control": "max-age=0",
    "Connection": "keep-alive",
    "Content-Type": "application/x-www-form-urlencoded",
    "sec-ch-ua":
        '".Not/A)Brand";v="99", "Google Chrome";v="103", "Chromium";v="103"',
    "Upgrade-Insecure-Requests": "1",
  };

  static void translate(File image) async {
    log("Image size before compressing:${image.lengthSync()}");
    File? compressed = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      join((await getApplicationSupportDirectory()).path,
          "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}_compressed.jpeg"),
      minWidth: 1920,
      minHeight: 1080,
    );
    log("Image size after compressing:${compressed!.lengthSync()}");
    print("Generating resonse");
    var request = MultipartRequest(
      "POST",
      Uri.parse("$serverUrl/upload_photo/"),
      onProgress: (bytes, totalBytes) {
        log("progress $bytes => $totalBytes");
      },
    );
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        compressed!.readAsBytesSync(),
        filename: "photo.jpg",
      ),
    );
    request.fields['lang'] = 'RU';
    request.fields['has_public_confirm'] = 'False';
    request.fields['find_orientation'] = 'True';
    request.fields['process_2_sides'] = 'False';
    request.headers.addAll(headers);
    print("Sending resonse");
    var response = await request.send();
    print(response.headers["location"]);
    print(response.isRedirect);
    print(await response.stream.bytesToString());
    print("Finish");
  }
}