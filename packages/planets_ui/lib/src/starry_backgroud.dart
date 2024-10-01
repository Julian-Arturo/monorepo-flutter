import 'dart:math';
import 'package:flutter/material.dart';

class StarryBackground extends StatefulWidget {

  const StarryBackground({
    required this.height, required this.width, super.key,
  });
  final double height;
  final double width;

  @override
  StarryBackgroundState createState() => StarryBackgroundState();
}

class StarryBackgroundState extends State<StarryBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> _starPositions;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _starPositions = List.generate(40, (index) => _getRandomOffset());
  }

  Offset _getRandomOffset() {
    return Offset(
      Random().nextDouble(),
      Random().nextDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _starPositions.map((offset) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              left: offset.dx * widget.width,
              top: offset.dy * widget.height,
              child: _buildStar(),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildStar() {
    return const Icon(
      Icons.star,
      color: Colors.yellow,
      size: 10,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
