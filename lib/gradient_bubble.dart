import 'package:flutter/material.dart';

import 'blend_mask.dart';

class GradientBubble extends StatefulWidget {
  GradientBubble({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    this.offset = Offset.zero,
    this.transformOrigin = Offset.zero,
    this.circleSize = 0.5,
    required this.tween,
    this.curve = Curves.linear,
    this.duration = Duration.zero,
  }) {
    center = Offset(
      (height / 2) - (height * circleSize) / 2,
      (width / 2) - (width * circleSize) / 2,
    );
  }

  final double width;
  final double height;
  final Color color;

  late final Offset center;
  final Offset offset;
  final Offset transformOrigin;
  final double circleSize;
  final Matrix4Tween tween;
  final Curve curve;
  final Duration duration;

  @override
  State<GradientBubble> createState() => _GradientBubbleState();
}

class _GradientBubbleState extends State<GradientBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late final Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: widget.duration);

    animation = widget.tween.animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );

    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Positioned(
        top: widget.center.dy + widget.offset.dy,
        left: widget.center.dx + widget.offset.dx,
        width: widget.width * widget.circleSize,
        height: widget.height * widget.circleSize,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return RepaintBoundary(
              child: Transform(
                origin: widget.transformOrigin,
                transform: animation.value,
                alignment: Alignment.center,
                child: RepaintBoundary(
                  child: BlendMask(
                    blendMode: BlendMode.hardLight,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          radius: 1,
                          stops: const [0, 0.8],
                          colors: [
                            widget.color.withOpacity(0.8),
                            widget.color.withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
