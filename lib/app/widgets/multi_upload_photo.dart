import 'dart:io';
import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/models/image_ps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class MultiUploadPhoto extends StatefulWidget {
  MultiUploadPhoto(
      {this.padding,
      this.iconSize,
      this.onChanged,
      this.image,
      this.height: 160,
      this.paddingPage: 15,
      this.max,
      this.errorText,
      this.initialImages});

  final double height;
  final double? iconSize;
  final double paddingPage;
  final EdgeInsetsGeometry? padding;
  final PickedFile? image;
  final ValueChanged<List<ImagePS>>? onChanged;
  final int? max;
  final String? errorText;
  final List<ImagePS>? initialImages;

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<MultiUploadPhoto> {
  List<ImagePS> _images = [];
  final _picker = ImagePicker();

  _takePhoto(ImageSource imageSource) async {
    if (imageSource == ImageSource.camera) {
      PickedFile? image = await _picker.getImage(source: ImageSource.camera);
      if (image == null) return;
      _onChanged(image: ImagePS(path: image.path, type: 0));
    } else {
      List<PickedFile>? images = await _picker.getMultiImage();
      if (images == null || images.length == 0) return;
      _onChanged(
          images: images.map((e) => ImagePS(path: e.path, type: 0)).toList());
    }
  }

  _onChanged({List<ImagePS>? images, ImagePS? image}) {
    List<ImagePS> imagesCopy = List.from(_images);

    if ((widget.max ?? 0) > 0) {
      if (image != null && (imagesCopy.length + 1) > widget.max!) {
        return;
      }
      if (images != null && (imagesCopy.length + images.length) > widget.max!) {
        return;
      }
    }

    if (images != null) imagesCopy.addAll(images);
    if (image != null) imagesCopy.add(image);

    setState(() {
      _images = imagesCopy;
    });
    widget.onChanged!(_images);
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialImages != null) {
      _onChanged(images: widget.initialImages);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    bool checkError() {
      return (widget.errorText ?? '') == ''
          ? true
          : _images.length == 0
              ? false
              : true;
    }

    final Widget svgIcon = SvgPicture.asset(
      'assets/images/icons/add_image.svg',
      color: checkError() ? Color(0xFF515863) : Colors.red,
      semanticsLabel: 'add image',
      width: widget.iconSize ?? 32,
      height: widget.iconSize ?? 32,
    );

    Widget _bodyText() {
      return Text(
        "Agregar fotos",
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: checkError() ? Color(0xFF515863) : Colors.red),
      );
    }

    Widget _buildBody() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Center(child: svgIcon), SizedBox(width: 10), _bodyText()],
      );
    }

    _removeImage(int index) {
      List<ImagePS> imagesCopy = List.from(_images);
      imagesCopy.removeAt(index);
      setState(() {
        _images = imagesCopy;
      });
      widget.onChanged!(_images);
    }

    Widget _removeBtn(int index) {
      return Container(
          padding: EdgeInsets.all(4),
          child: Material(
            elevation: 0.0,
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(50),
            color: Colors.black.withOpacity(0.6),
            child: InkWell(
              onTap: () => _removeImage(index),
              child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ));
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
                        "Agregar fotos",
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

    Widget _photoPickerBox({bool full = false}) {
      return Container(
        width: full ? width : width * 0.5,
        child: Stack(
          children: [
            Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: secundaryColors1,
                    border: checkError() ? null : Border.all(color: Colors.red),
                    shape: BoxShape.rectangle),
                child: _buildBody()),
            Container(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  splashColor: Theme.of(context).accentColor.withOpacity(0.2),
                  onTap: () {
                    _modalBottomSheetMenu();
                  },
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _buildImage(ImagePS image, int index) {
      return Container(
        constraints:
            BoxConstraints(minWidth: width * 0.1, maxWidth: width * 0.5),
        height: widget.height,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Stack(
            children: [
              Container(
                height: widget.height,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: image.type == 0
                        ? Image.file(File(image.path!), fit: BoxFit.cover)
                        : Image.network(image.path!, fit: BoxFit.cover)),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(child: _removeBtn(index)),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildList() {
      return Container(
        width: width,
        height: widget.height,
        child: ListView(scrollDirection: Axis.horizontal, children: [
          SizedBox(width: widget.paddingPage),
          for (var i = 0; i < _images.length; i++) _buildImage(_images[i], i),
          _photoPickerBox(),
          SizedBox(width: widget.paddingPage),
        ]),
      );
    }

    return Padding(
      padding: widget.padding ?? EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: width,
              height: widget.height,
              child: _images.length == 0
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widget.paddingPage),
                      child: _photoPickerBox(full: true),
                    )
                  : _buildList()),
          checkError()
              ? Container()
              : Padding(
                  padding:
                      EdgeInsets.only(left: widget.paddingPage + 10, top: 6),
                  child: Text(widget.errorText!,
                      style: TextStyle(color: Colors.red, fontSize: 12)),
                )
        ],
      ),
    );
  }
}
