import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pPath;
import 'package:provider/provider.dart';
import 'package:private_photo_album/models/picture.dart';
import 'package:private_photo_album/providers/pictures.dart';

class AddPhotoScreen extends StatefulWidget {
  static const routeName = '/add_photo_screen';

  @override
  _AddPhotoScreenState createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  File _takenImage;

  Future<void> _takePictureFromPhotoFolder() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageFile == null) {
      return;
    }

    setState(() {
      _takenImage = imageFile;
    });

    final appDir = await pPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');

    var _imageToStore = Picture(picName: savedImage);

    _storeImage() {
      Provider.of<Pictures>(context, listen: false).storeImage(_imageToStore);
    }

    _storeImage();
  }

  Future<void> _takePictureUsingCamera() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (imageFile == null) {
      return;
    }

    setState(() {
      _takenImage = imageFile;
    });

    final appDir = await pPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');

    var _imageToStore = Picture(picName: savedImage);

    _storeImage() {
      Provider.of<Pictures>(context, listen: false).storeImage(_imageToStore);
    }

    _storeImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.add_a_photo),
                iconSize: 100.0,
                color: Colors.black87,
                onPressed: _takePictureUsingCamera,
              ),
            ),
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.add_photo_alternate_rounded),
                iconSize: 110.0,
                color: Colors.black87,
                onPressed: _takePictureFromPhotoFolder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
