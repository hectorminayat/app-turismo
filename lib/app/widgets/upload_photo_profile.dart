import 'dart:io';

import 'package:discoverrd/app/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoProfile extends StatefulWidget {
  const UploadPhotoProfile(
      {this.height,
      this.width,
      this.padding,
      this.circle: false,
      this.full: false,
      this.iconSize,
      this.onChanged,
      this.defaultImage})
      : super();
  final double? height;
  final double? width;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final bool circle;
  final bool full;
  final String? defaultImage;
  final ValueChanged<PickedFile?>? onChanged;

  @override
  _UploadPhotoProfileState createState() => _UploadPhotoProfileState();
}

class _UploadPhotoProfileState extends State<UploadPhotoProfile> {
  PickedFile? _image;
  final _picker = ImagePicker();

  _takePhoto(ImageSource imageSource) async {
    PickedFile? image = await _picker.getImage(source: imageSource);

    if (image != null) {
      _onChanged(image);
    }
  }

  _onChanged(PickedFile? image) {
    setState(() {
      _image = image;
    });

    widget.onChanged!(image);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget _editBtn() {
      return Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.edit, color: Colors.white),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
        ),
      );
    }

    void _modalBottomSheetMenu() {
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(30.0)),
          ),
          builder: (context) {
            return Container(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Tomar foto",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    leading: Icon(Icons.camera_alt, size: 28),
                    title: Text('Tomar una nueva foto'),
                    onTap: () {
                      Navigator.pop(context);
                      _takePhoto(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    leading: Icon(
                      Icons.image,
                      size: 28,
                    ),
                    title: Text('Tomar de galeria'),
                    onTap: () {
                      Navigator.pop(context);
                      _takePhoto(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            );
          });
    }

    return Container(
      padding: widget.padding ?? EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          (_image != null ||
                  (widget.defaultImage != null &&
                      widget.defaultImage!.isNotEmpty))
              ? Container(
                  width:
                      widget.width != null ? widget.width! * 0.5 : width * 0.5,
                  height: widget.height ?? 120.0,
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: (_image != null)
                                  ? DecorationImage(
                                      image: FileImage(File(_image!.path)),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: NetworkImage(widget.defaultImage!),
                                      fit: BoxFit.cover))),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Container(child: _editBtn())),
                  ]),
                )
              : Container(
                  width:
                      widget.width != null ? widget.width! * 0.5 : width * 0.5,
                  height: widget.height ?? 120.0,
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      color: secundaryColors1, shape: BoxShape.circle),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.person,
                          size: 44,
                          color: Color(0xFF97A5BB),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Container(child: _editBtn())),
                    ],
                  )),
          Container(
            width: widget.width != null ? widget.width! * 0.5 : width * 0.5,
            height: widget.height ?? 120.0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: CircleBorder(),
                borderRadius: BorderRadius.circular(20.0),
                splashColor: Theme.of(context).accentColor.withOpacity(0.2),
                onTap: () {
                  _modalBottomSheetMenu();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
