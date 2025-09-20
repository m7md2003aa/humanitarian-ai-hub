import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  final _uuid = const Uuid();

  Future<String> uploadDonationImage(File file) async {
    // Compress to a temp JPEG (~25–40% size)
    final tempDir = await getTemporaryDirectory();
    final outPath = '${tempDir.path}/${_uuid.v4()}.jpg';

    final compressed = await FlutterImageCompress.compressAndGetFile(
      file.path,
      outPath,
      quality: 75,
    );

    final toUpload = File(compressed?.path ?? file.path);
    final ref = _storage.ref().child('donations/${_uuid.v4()}.jpg');

    final task = await ref.putFile(
      toUpload,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return await task.ref.getDownloadURL();
  }
}
