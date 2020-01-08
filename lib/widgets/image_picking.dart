import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePicking extends StatefulWidget {
  ImagePicking({@required this.imagePickingHandler});
  final Function imagePickingHandler;
  @override
  _ImagePickingState createState() => _ImagePickingState();
}

class _ImagePickingState extends State<ImagePicking> {
  File _image;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 150.0,
          width: 150.0,
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: _image == null
              ? Text("No image selected")
              : Image.file(
                  _image,
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
              icon: Icon(Icons.image),
              label: Text("Gallery"),
              onPressed: () async {
                var image = await ImagePicker.pickImage(
                  source: ImageSource.gallery,
                );
                setState(() {
                  _image = image;
                });
                widget.imagePickingHandler(_image);
              },
            ),
            RaisedButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text("Camera"),
              onPressed: () async {
                var image = await ImagePicker.pickImage(
                  source: ImageSource.camera,
                );
                setState(() {
                  _image = image;
                });
                widget.imagePickingHandler(_image);
              },
            ),
          ],
        ),
      ],
    );
  }
}
