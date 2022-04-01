import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

typedef OnImageSelected = Function(File imageFile);

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerWidget> {
  File? image;

  Future _showPickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Fallo al seleccionar imágen: $e');
    }
  }

  Future _showPickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Fallo al seleccionar imágen: $e');
    }
  }

  void _showPickerOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera"),
                  onTap: () => {
                        _showPickImageCamera(),
                        Navigator.of(context),
                      }),
              ListTile(
                  leading: Icon(Icons.image),
                  title: Text("Gallery"),
                  onTap: () => {
                        _showPickImageGallery(),
                        Navigator.of(context),
                      }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      child: Column(
        children: [
          (image != null)
              ? (Image.file(image!, width: double.infinity, height: 270))
              : SizedBox(height: 50),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              _showPickerOptions(context);
            },
            iconSize: 120,
            color: Colors.white,
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade300,
            Colors.green.shade800,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
    /*  backgroundColor: Colors.green.shade300,
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Spacer(),
              image != null
                  ? Image.file(image!,
                      width: 160, height: 160, fit: BoxFit.cover)
                  : FlutterLogo(size: 160),
              const SizedBox(height: 24),
              Text(
                'ImagePicker',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                  onPressed: () => _showPickImage(),
                  icon: Icon(Icons.camera_alt)),
              Spacer(),
            ],
          ),
        ),*/
  }
}
