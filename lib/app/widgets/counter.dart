import 'dart:ui';

import 'package:discoverrd/app/config/theme_config.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Counter extends StatefulWidget {
  Counter(
      {required this.lowerLimit,
      required this.upperLimit,
      required this.stepValue,
      required this.iconSize,
      this.value: 0,
      this.onChanged});

  final ValueChanged<int>? onChanged;

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black, // red as border color
                ),
              ),
              child: InkWell(
                splashColor: primaryColor.withOpacity(0.4),
                onTap: () {
                  var value = widget.value == widget.lowerLimit
                      ? widget.lowerLimit
                      : widget.value -= widget.stepValue;
                  setState(() {
                    widget.value = value;
                    if (widget.onChanged != null) {
                      widget.onChanged!(widget.value);
                    }
                  });
                },
                child: SizedBox(
                    width: widget.iconSize * 1.8,
                    height: widget.iconSize * 1.8,
                    child: Icon(Icons.remove, size: widget.iconSize)),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Container(
          width: widget.iconSize,
          child: Text(
            '${widget.value}',
            style: TextStyle(
                fontSize: widget.iconSize * 1.1, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 16),
        ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black, // red as border color
                ),
              ),
              child: InkWell(
                splashColor: primaryColor.withOpacity(0.4),
                onTap: () {
                  var value = widget.value == widget.upperLimit
                      ? widget.upperLimit
                      : widget.value += widget.stepValue;
                  setState(() {
                    widget.value = value;
                  });
                  print(value);
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                },
                child: SizedBox(
                    width: widget.iconSize * 1.8,
                    height: widget.iconSize * 1.8,
                    child: Icon(Icons.add, size: widget.iconSize)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
