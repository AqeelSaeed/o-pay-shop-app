

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  final Uint8List bytes ;
  const ImageScreen({super.key, required this.bytes});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Image.memory(widget.bytes),
      ),
    );
  }
}
