import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Img;
import 'package:photo_view/photo_view.dart';

class SaveImageScreen extends StatefulWidget {
  final List arguments;
  SaveImageScreen({this.arguments});
  @override
  _SaveImageScreenState createState() => _SaveImageScreenState();
}

class _SaveImageScreenState extends State<SaveImageScreen> {
  File image;
  List<int> imageBytes;
  List<int> imageBytesThumb;
  @override
  void initState() {
    super.initState();
    image = widget.arguments[0];
  }

  Future saveImage() async {
    Img.Image editedImage = Img.decodeImage(image.readAsBytesSync());
    File(image.path.split('.')[0] + '1' + image.path.split('.')[1])
      ..writeAsBytesSync(Img.encodePng(editedImage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          "Export Photo",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Container(
                color: Theme.of(context).hintColor,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: PhotoView(
                  imageProvider: FileImage(image),
                  backgroundDecoration: BoxDecoration(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
            ),
            //
            Spacer(),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                      heroTag: "SAVE",
                      icon: Icon(Icons.save),
                      label: Text("SAVE"),
                      onPressed: () {
                        saveImage();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                      heroTag: "SHARE",
                      icon: Icon(Icons.share),
                      label: Text("SHARE"),
                      onPressed: () {}),
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(
                      child: Icon(
                        Icons.info,
                        color: Theme.of(context).accentColor.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Text(
                          "Note - The images are saved in the best possible quality.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
