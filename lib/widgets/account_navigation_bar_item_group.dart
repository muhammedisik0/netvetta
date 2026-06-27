import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_bottom_navigation_bar_item.dart';

class AccountNavigationBarItemGroup extends StatelessWidget {
  final VoidCallback onPersonalPressed;
  final VoidCallback onLogoutPressed;
  final bool isSelected;

  const AccountNavigationBarItemGroup({
    super.key,
    required this.onPersonalPressed,
    required this.onLogoutPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomBottomNavigationBarItem(
          onTap: onPersonalPressed,
          isSelected: isSelected,
          icon: FontAwesomeIcons.solidUser,
          text: 'Kişisel',
          iconSize: 16.5,
          fontSize: 10.5,
        ),
        SizedBox(
          height: 20,
          child: VerticalDivider(
            width: 20,
            thickness: 1,
            color: isSelected ? Colors.black : Colors.black45,
          ),
        ),
        CustomBottomNavigationBarItem(
          onTap: onLogoutPressed,
          isSelected: isSelected,
          icon: FontAwesomeIcons.arrowRightFromBracket,
          text: 'Çıkış',
          iconSize: 16.5,
          fontSize: 10.5,
        ),
      ],
    );
  }
}
