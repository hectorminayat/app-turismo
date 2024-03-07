import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/services/tour_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikeButton extends StatefulWidget {
  
  const LikeButton({
    this.initialValue: false,
    this.large:  true,
    required this.tourId
  });

  final bool initialValue;
  final int tourId;
  final bool large;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool like = false;
  final TourService _service = Get.find<TourService>();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    like = widget.initialValue;
  }

  void _onTap() async {
    final newlike = !like;
    if(newlike) {
      await _service.like(widget.tourId);
    }
    else {
      await _service.dislike(widget.tourId);
    }

    setState(() {
      like  = newlike;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        shape: CircleBorder(),
        child: InkWell(
          customBorder: CircleBorder(),
          splashColor: primaryColor,
          onTap: _onTap,
          child: Container(
              padding: EdgeInsets.all(widget.large ? 8 : 6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white.withOpacity(0.8)),
              child: Icon(like ? Icons.favorite : Icons.favorite_border, color: primaryColor, size: widget.large ? 26 : 20)),
        ),
      ),
    );
  }
}
