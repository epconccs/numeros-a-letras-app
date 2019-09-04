import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  String _path;
  double _height;
  double _width;
  Image image;
  ImageView(this._path, this._height, this._width);

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage(_path);
    Image image = Image(image: assetImage);
    return Container(
      child: image,
      height: _height,
      width: _height,
    );
  }
}