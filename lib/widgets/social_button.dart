import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.color,
  }) : super(key: key);

  final Function() onPressed;
  final FaIconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 20,
      child: IconButton(
        onPressed: onPressed,
        icon: FaIcon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
