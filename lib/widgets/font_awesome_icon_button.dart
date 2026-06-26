import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FontAwesomeIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final FaIconData icon;
  final Color color;

  const FontAwesomeIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 20,
      child: IconButton(
        onPressed: onPressed,
        icon: FaIcon(icon, size: 20, color: Colors.white),
      ),
    );
  }
}
