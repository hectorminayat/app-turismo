import 'dart:io';

import 'package:discoverrd/app/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto(
      {this.height,
      this.width,
      this.padding,
      this.circle: false,
      this.full: false,
      this.iconSize,
      this.onChanged,
      this.image})
      : super();
  final double? height;
  final double? width;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final bool circle;
  final bool full;
  final PickedFile? image;
  final ValueChanged<PickedFile?>? onChanged;

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
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

    final Widget svgIcon = SvgPicture.asset(
      'assets/images/icons/add_image.svg',
      color: Color(0xFF97A5BB),
      semanticsLabel: 'add image',
      width: widget.iconSize ?? (widget.full ? 52 : 32),
      height: widget.iconSize ?? (widget.full ? 52 : 32),
    );

    Widget _bodyText() {
      return Text(
        "Tomar foto",
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Color(0xFF97A5BB)),
      );
    }

    Widget _buildBody() {
      return widget.full
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: svgIcon),
                SizedBox(height: 10),
                _bodyText()
              ],
            )
          : widget.circle
              ? Center(child: svgIcon)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: svgIcon),
                    SizedBox(width: 10),
                    _bodyText()
                  ],
                );
    }

    Widget _closeBtn() {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            _onChanged(null);
          });
        },
        child: Icon(Icons.close, color: Colors.white),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(5)),
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all(CircleBorder()),
          backgroundColor:
              MaterialStateProperty.all(Colors.red.withOpacity(0.8)),
          overlayColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
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
          Container(
              width: widget.width != null
                  ? widget.circle
                      ? widget.width! * 0.5
                      : widget.width
                  : widget.circle
                      ? width * 0.5
                      : width,
              height: widget.height ?? 120.0,
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  borderRadius:
                      widget.circle ? null : BorderRadius.circular(20),
                  color: secundaryColors1,
                  shape: widget.circle ? BoxShape.circle : BoxShape.rectangle),
              child: _buildBody()),
          Container(
            width: widget.width != null
                ? widget.circle
                    ? widget.width! * 0.5
                    : widget.width
                : widget.circle
                    ? width * 0.5
                    : width,
            height: widget.height ?? 120.0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: widget.circle ? CircleBorder() : null,
                borderRadius: BorderRadius.circular(20.0),
                splashColor: Theme.of(context).accentColor.withOpacity(0.2),
                onTap: () {
                  _modalBottomSheetMenu();
                },
              ),
            ),
          ),
          (_image != null || widget.image != null)
              ? Container(
                  width: widget.width != null
                      ? widget.circle
                          ? widget.width! * 0.5
                          : widget.width
                      : widget.circle
                          ? width * 0.5
                          : width,
                  height: widget.height ?? 120.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.circle
                            ? Container(
                                decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(File(_image != null
                                        ? _image!.path
                                        : widget.image!.path)),
                                    fit: BoxFit.cover),
                              ))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.file(
                                    File(_image != null
                                        ? _image!.path
                                        : widget.image!.path),
                                    fit: BoxFit.cover)),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(child: _closeBtn())),
                    ],
                  ),
                )
              : SizedBox(width: 0, height: 0)
        ],
      ),
    );
  }
}
