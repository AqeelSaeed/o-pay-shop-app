import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamapay_shop_app/utils/shared_pref.dart';

class ImagePickerState extends ChangeNotifier {
  File? pickedImageFile;

  void pickImageFromGallery(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      pickedImageFile = File(image.path);
      notifyListeners();
    }
  }

  void getImage() {
    String userImage = SharedPref.getString(key: 'user-image');
    if (userImage.isEmpty) {
      pickedImageFile == null;
    } else {
      pickedImageFile = File(userImage);
    }
    notifyListeners();
  }
}
