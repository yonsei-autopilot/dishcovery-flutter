import 'package:flutter/material.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';

class BodyText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight weight;
  final overflow;
  final TextAlign textAlign;
  final bool shadow;
  const BodyText({
    super.key,
    this.size = 16,
    required this.text,
    this.color = primaryBlack,
    this.weight = FontWeight.normal,
    this.overflow = TextOverflow.clip,
    this.textAlign = TextAlign.start,
    this.shadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontFamily: 'SFProRegular',
        fontSize: size,
        fontWeight: weight,
        overflow: overflow,
        shadows: shadow ? <Shadow> [Shadow(offset: Offset(2.5, 2.5), blurRadius: 10, color: primaryGrey)] : null,
      ),
    );
  }
}