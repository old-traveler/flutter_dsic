import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsic/disc_item.dart';

class Disc extends StatefulWidget {
  final List<DiscItem> items;
  final Duration duration;
  final EdgeInsets padding;
  final double radius;
  final double strokeWidth;

  const Disc(
      {Key key,
      this.items,
      this.duration,
      this.padding,
      this.radius,
      this.strokeWidth: 20})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DiscState();
  }
}

class _DiscState extends State<Disc> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.addListener(() {
      if (mounted) setState(() {});
    });
    controller.forward();
  }

  @override
  void reassemble() {
    super.reassemble();
    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Widget custom = CustomPaint(
      size: Size.fromHeight(widget.radius * 3),
      painter: _DiscPaint(
          items: widget.items,
          radius: widget.radius,
          value: animation.value,
          strokeWidth: widget.strokeWidth),
    );
    if (widget.padding != null) {
      custom = Padding(padding: widget.padding, child: custom);
    }
    return custom;
  }
}

class _DiscPaint extends CustomPainter {
  final List<DiscItem> items;
  final double radius;
  final double value;
  final double strokeWidth;
  Paint mPaint;

  _DiscPaint({
    this.items,
    this.radius,
    this.value,
    this.strokeWidth,
  }) : assert(value >= 0.0 && value <= 1.0) {
    mPaint = Paint()
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print('$value');
    Rect rect =
        Offset(size.width / 2 - radius, radius / 2) & Size.fromRadius(radius);
    double total = 0;
    items.forEach((item) => total += item.value);
    double totalAngle = value * 2 * pi;
    double temp = 0;
    mPaint.color = Colors.white;
    canvas.drawArc(rect, 0, 2 * pi, false, mPaint);
    items.forEach((item) {
      mPaint.color = item.color;
      final start = (temp / total) * totalAngle;
      temp += item.value;
      final end = (temp / total) * totalAngle;
      canvas.drawArc(rect, start, end - start, false, mPaint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
