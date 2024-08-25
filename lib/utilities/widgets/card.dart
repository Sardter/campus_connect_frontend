import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class SocialUtilCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? background;
  final Color? boxShadow;
  final BorderRadius? borderRadius;
  final bool fullScreen;
  final double? width;
  final double? height;
  final ImageProvider? backgroundImage;

  final void Function()? onTap;
  const SocialUtilCard(
      {Key? key,
      required this.child,
      this.fullScreen = false,
      this.padding,
      this.borderRadius,
      this.margin,
      this.background,
      this.boxShadow,
      this.backgroundImage,
      this.onTap,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          height: height,
          clipBehavior: Clip.hardEdge,
          constraints: BoxConstraints(maxWidth: width ?? 600),
          decoration: BoxDecoration(
            color: background ?? ThemeService.menuBackground,
            image: backgroundImage == null
                ? null
                : DecorationImage(image: backgroundImage!, fit: BoxFit.cover),
            borderRadius: borderRadius ??
                (fullScreen
                    ? ThemeService.fullScreenBorderRadius
                    : ThemeService.allAroundBorderRadius),
            boxShadow: boxShadow != null
                ? [BoxShadow(color: boxShadow!, blurRadius: 5, spreadRadius: 2)]
                : ThemeService.defaultBoxShadow,
          ),
          margin: fullScreen ? null : margin ?? ThemeService.defaultMargin,
          padding: fullScreen ? null : padding ?? ThemeService.defaultPadding,
          child: child),
    );
  }
}