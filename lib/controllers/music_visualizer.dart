library music_visualizer;

import "package:flutter/material.dart";
import 'package:flutter/animation.dart';
import 'package:wethepeople/views/homepage.dart';

class MusicVisualizer extends StatelessWidget {
  final List<Color>? colors;
  final List<int>? duration;
  final int? barCount;
  final Curve? curve;

  const MusicVisualizer({
    Key? key,
    @required this.colors,
    @required this.duration,
    @required this.barCount,
    this.curve = Curves.easeInQuad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
            barCount!,
            (index) => VisualComponent(
                curve: curve!,
                duration: duration![index % 5],
                color: colors![index % 4])));
  }
}

class VisualComponent extends StatefulWidget {
  final int? duration;
  final Color? color;
  final Curve? curve;

  const VisualComponent(
      {Key? key,
      @required this.duration,
      @required this.color,
      @required this.curve})
      : super(key: key);

  @override
  _VisualComponentState createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;
  Stream stream = streamController.stream;

  @override
  void initState() {
    super.initState();
    animate();
    stream.listen((event) {
      !event
          ? animationController!.repeat(reverse: true)
          : animationController!.stop();
    });
  }

  @override
  void dispose() {
    animation!.removeListener(() {});
    animation!.removeStatusListener((status) {});
    animationController!.stop();
    animationController!.reset();
    animationController!.dispose();
    super.dispose();
  }

  void animate() {
    animationController = AnimationController(
        duration: Duration(milliseconds: widget.duration!), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: animationController!, curve: widget.curve!);
    animation = Tween<double>(begin: 0, end: 50).animate(curvedAnimation)
      ..addListener(() {
        update();
      });
    // animationController!.repeat(reverse: true);
  }

  void update() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: animation!.value,
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(5)),
    );
  }
}
