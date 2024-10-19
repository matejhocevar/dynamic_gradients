import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'gradient_bubble.dart';
import 'shader_helpers/shader_effect.dart';

late FragmentProgram fragmentProgram;

Future<void> main() async {
  fragmentProgram =
      await FragmentProgram.fromAsset('assets/shaders/goo_shader.frag');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final List<Color> bgColors = const [
    Color.fromRGBO(108, 0, 162, 1),
    Color.fromRGBO(0, 17, 82, 1),
  ];
  final interactiveColor = const Color.fromRGBO(105, 255, 100, 1.0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    Widget content = Stack(
      children: [
        // Gradient 1
        GradientBubble(
          width: width,
          height: height,
          color: const Color.fromRGBO(18, 113, 255, 1),
          tween: Matrix4Tween(
            begin: Matrix4.identity()..setTranslationRaw(0, -height / 2, 0),
            end: Matrix4.identity()..setTranslationRaw(0, height / 2, 0),
          ),
          duration: 20.seconds,
          curve: Curves.ease,
        ),
        // Gradient 2
        GradientBubble(
          width: width,
          height: height,
          color: const Color.fromRGBO(211, 74, 255, 1),
          transformOrigin: const Offset(300, -240),
          tween: Matrix4Tween(
            begin: Matrix4.identity()..rotateZ(180),
            end: Matrix4.identity()
              ..rotateZ(0)
              ..setTranslationRaw(width / 2, height / 10, 0),
          ),
          duration: 20.seconds,
          curve: Curves.linear,
        ),
        // Gradient 3
        GradientBubble(
          width: width,
          height: height,
          color: const Color.fromRGBO(110, 220, 255, 1),
          offset: Offset(width / 2 - 200, height / 2 - 500),
          transformOrigin: const Offset(400, 0),
          tween: Matrix4Tween(
            begin: Matrix4.identity()..rotateZ(0),
            end: Matrix4.identity()..rotateZ(180),
          ),
          duration: 40.seconds,
          curve: Curves.linear,
        ),
        // Gradient 4
        GradientBubble(
          width: width,
          height: height,
          color: const Color.fromRGBO(105, 255, 100, 1.0),
          transformOrigin: const Offset(-400, -50),
          tween: Matrix4Tween(
            begin: Matrix4.identity()
              ..setTranslationRaw(-width / 2, -height / 10, 0),
            end: Matrix4.identity()
              ..setTranslationRaw(width / 2, height / 10, 0),
          ),
          duration: 30.seconds,
          curve: Curves.linear,
        ),
        // Gradient 5
        GradientBubble(
          width: width,
          height: height,
          color: const Color.fromRGBO(180, 180, 50, 1),
          transformOrigin: const Offset(10, -150),
          tween: Matrix4Tween(
            begin: Matrix4.identity()..rotateZ(0),
            end: Matrix4.identity()..rotateZ(180),
          ),
          duration: 10.seconds,
          curve: Curves.ease,
        ),
      ],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: bgColors),
            ),
          ),
          Center(
            child: AnimatedSampler(
              (image, size, canvas) {
                final shader = fragmentProgram.fragmentShader();
                shader
                  ..setFloat(0, size.width)
                  ..setFloat(1, size.height)
                  ..setImageSampler(0, image);
                Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
                canvas.drawRect(rect, Paint()..shader = shader);
              },
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
