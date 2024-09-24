import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      log("xfile ====${xfile.toString()} name-${xfile.name}  file ---- ${xfile.path}");
      return File(xfile.path);
    }
    return null;
  } catch (e) {
    log("pick image error $e");
    return null;
  }
}
