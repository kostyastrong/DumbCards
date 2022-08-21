import 'package:flutter/material.dart';
import 'package:flutter_cool_card_swiper/constants.dart';

class CardWrapper extends StatefulWidget {
  final Widget child;
  final double initialScale;
  final double initialYOffset;
  final bool fire;
  final AnimationController animationController;
  CardWrapper({
    Key? key,
    required this.child,
    this.initialScale = 1,
    this.initialYOffset = 0,
    this.fire = false,
    required this.animationController,
  }) : super(key: key);

  @override
  State<CardWrapper> createState() => _CardWrapperState();
}

class _CardWrapperState extends State<CardWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> yOffsetAnimation;
  late final Animation<double> scaleAnimation;
  late final Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    animationController = widget.animationController;

    yOffsetAnimation = Tween<double>(
      begin: widget.initialYOffset,
      end: widget.initialYOffset - Constants.yOffset,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );

    scaleAnimation = Tween<double>(
      begin: widget.initialScale,
      end: widget.initialScale + Constants.scaleFraction,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );
    final end = widget.initialScale + Constants.scaleFraction;
    final begin = widget.initialScale;
    opacityAnimation = Tween<double>(
      begin: begin > 1 ? 1.0 : begin,
      end: end > 1 ? 1.0 : end,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (c, child) => Transform.translate(
        offset: Offset(0, -yOffsetAnimation.value),
        child: Transform.scale(
          scale: scaleAnimation.value,
          child: Opacity(opacity: opacityAnimation.value, child: child),
        ),
      ),
      child: widget.child,
    );
  }
}
