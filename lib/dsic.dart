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
  TextStyle topTextStyle;
  TextStyle bottomTextStyle;
  Paint mPaint;
  TextPainter topTextPainter;
  TextPainter bottomTextPainter;

  _DiscPaint({
    this.items,
    this.radius,
    this.value,
    this.strokeWidth,
    this.topTextStyle,
    this.bottomTextStyle,
  }) : assert(value >= 0.0 && value <= 1.0) {
    mPaint = Paint()
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;
    topTextPainter =
        TextPainter(textAlign: TextAlign.end, textDirection: TextDirection.rtl);
    bottomTextPainter =
        TextPainter(textAlign: TextAlign.end, textDirection: TextDirection.rtl);
    double alpha = ((max((value - 0.85), 0) / 0.15) * 255);
    Color topColor = Color.fromARGB(
        alpha.toInt(), Colors.black.red, Colors.black.green, Colors.black.blue);
    Color bottomColor = Color.fromARGB(
        alpha.toInt(), Colors.grey.red, Colors.grey.green, Colors.grey.blue);
    topTextStyle ??=
        TextStyle(fontSize: 11, color: topColor, fontWeight: FontWeight.w600);
    bottomTextStyle ??= TextStyle(fontSize: 10, color: bottomColor);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Rect rect = Offset(-radius, -radius) & Size.fromRadius(radius);
    double total = 0;
    items.forEach((item) => total += item.value);
    double totalAngle = (value * 4).clamp(0, 2) * pi;
    double temp = 0;
    mPaint.color = Colors.transparent;
    canvas.drawArc(rect, 0, 2 * pi, false, mPaint);
    Offset lastPaintPoint;
    Offset firstPaintPoint;
    items.forEach((item) {
      mPaint.style = PaintingStyle.stroke;
      mPaint.strokeWidth = strokeWidth;
      mPaint.color = item.color;
      final start = (temp / total) * totalAngle;
      temp += item.value;
      final end = (temp / total) * totalAngle;
      canvas.drawArc(rect, start, end - start, false, mPaint);
      mPaint.style = PaintingStyle.fill;
      final radians = ((temp - item.value / 2) / total) * 2 * pi;
      final startPoint = getPointByRadians(radians, radius * 9 / 7);
      final endPoint = getPointByRadians(radians, radius * 9 / 7 + 20);
      final itemRadius = radius / 20;
      final itemRect = startPoint.translate(-itemRadius, -itemRadius) &
          Size.fromRadius(itemRadius);
      mPaint.strokeWidth = 1;
      final lastPoint = getPointByMidPoint(size, endPoint);
      bool canPaint(Offset it, Offset other) {
        if (other == null) {
          return true;
        }
        return (it.dx * other.dx < 0) ||
            (it.dy - other.dy).abs() >
                topTextStyle.fontSize + 12 + bottomTextStyle.fontSize;
      }

      if (canPaint(lastPoint, lastPaintPoint) &&
          canPaint(lastPoint, firstPaintPoint)) {
        canvas.drawArc(
            itemRect, 0, (value * 4).clamp(0, 2) * pi, false, mPaint);
        paintItemLine(canvas, startPoint, endPoint, lastPoint, item);
        lastPaintPoint = lastPoint;
        firstPaintPoint ??= lastPoint;
      }
    });
  }

  void paintItemLine(Canvas canvas, Offset startPoint, Offset midPoint,
      Offset lastPoint, DiscItem item) {
    if (value > 0.5) {
      double scale = ((value - 0.5) / 0.2).clamp(0.0, 1.0);
      final _endPoint = Offset(
          startPoint.dx + (midPoint.dx - startPoint.dx) * scale,
          startPoint.dy + (midPoint.dy - startPoint.dy) * scale);
      canvas.drawLine(startPoint, _endPoint, mPaint);
    }
    if (value > 0.7) {
      double scale = ((value - 0.7) / 0.3).clamp(0.0, 1.0);
      final _lastPoint = Offset(
          midPoint.dx + (lastPoint.dx - midPoint.dx) * scale,
          midPoint.dy + (lastPoint.dy - midPoint.dy) * scale);
      canvas.drawLine(midPoint, _lastPoint, mPaint);
    }
    topTextPainter.text = TextSpan(text: item.topText, style: topTextStyle);
    bottomTextPainter.text =
        TextSpan(text: item.bottomText, style: bottomTextStyle);
    topTextPainter.layout();
    topTextPainter.paint(
        canvas,
        lastPoint.translate(lastPoint.dx <= 0 ? 0 : -topTextPainter.width,
            -(topTextStyle.fontSize + 8)));
    bottomTextPainter.layout();
    bottomTextPainter.paint(
        canvas,
        lastPoint.translate(
            lastPoint.dx <= 0 ? 0 : -bottomTextPainter.width, 5));
  }

  Offset getPointByMidPoint(Size size, Offset offset) {
    if (offset.dx >= 0) {
      return Offset(size.width / 2 - 10, offset.dy);
    } else {
      return Offset(-size.width / 2 + 10, offset.dy);
    }
  }

  Offset getPointByRadians(double radians, double length) {
    return Offset(cos(radians) * length, sin(radians) * length);
  }

  @override
  bool shouldRepaint(_DiscPaint oldDelegate) {
    return oldDelegate.value != value;
  }
}
