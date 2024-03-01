// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double min;
  final double max;
  final double stepValue;
  final double defaultValue; // Başlangıç değeri eklendi
  final Function(double) onChanged;
  final Color? toggleColor;

  const CustomSlider({
    Key? key,
    required this.min,
    required this.max,
    required this.stepValue,
    required this.defaultValue,
    required this.onChanged,
    this.toggleColor,
  }) : super(key: key);

  @override
  CustomSliderState createState() => CustomSliderState();
}

class CustomSliderState extends State<CustomSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue =
        widget.defaultValue; // Başlangıç değeri _currentValue'a atanıyor
    // Başlangıç değeri stepValue'ye uygun olmalıdır, burada yuvarlama yapılabilir
    final double stepsFromMin =
        ((_currentValue - widget.min) / widget.stepValue).round().toDouble();
    _currentValue = widget.min + stepsFromMin * widget.stepValue;
  }

  void _updateValue(Offset localPosition, BoxConstraints constraints) {
    final double newRatio = localPosition.dx / constraints.maxWidth;
    final double totalRange = widget.max - widget.min;
    final double newValue =
        ((totalRange * newRatio) / widget.stepValue).round() *
                widget.stepValue +
            widget.min;
    setState(() {
      _currentValue = newValue.clamp(widget.min, widget.max);
    });
    widget.onChanged(_currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            _updateValue(details.localPosition, constraints);
          },
          onTapDown: (details) {
            _updateValue(details.localPosition, constraints);
          },
          child: Container(
            width: double.infinity,
            height: 40,
            color: Colors.transparent,
            child: CustomPaint(
              painter: _SliderPainter(
                value: _currentValue,
                min: widget.min,
                max: widget.max,
                toggleColor: widget.toggleColor ?? Colors.blue,
                divisions:
                    ((widget.max - widget.min) / widget.stepValue).round(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SliderPainter extends CustomPainter {
  double value;
  double min;
  double max;
  int divisions;
  Color toggleColor;

  _SliderPainter({
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.toggleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var trackPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    var thumbPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTWH(0, size.height / 2 - 2, size.width, 4), trackPaint);
    double thumbPosition = ((value - min) / (max - min)) * size.width;
    canvas.drawCircle(Offset(thumbPosition, size.height / 2), 10, thumbPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
