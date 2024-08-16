import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';

class NavTab extends StatelessWidget {
  const NavTab(
      {super.key,
      required IconData iconData,
      required String text,
      required bool isSelected,
      required Function onTap,
      required IconData selectedIcon,
      required this.selectedIndex})
      : _iconData = iconData,
        _text = text,
        _isSelected = isSelected,
        _onTap = onTap,
        _selectedIcon = selectedIcon;

  final IconData _iconData;
  final IconData _selectedIcon;
  final String _text;
  final bool _isSelected;
  final Function _onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _onTap(),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: _isSelected ? 1 : 0.6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                _isSelected ? _selectedIcon : _iconData,
                color: selectedIndex == 0 ? Colors.white : Colors.black,
              ),
              Gaps.v5,
              Text(
                _text,
                style: TextStyle(
                  color: selectedIndex == 0 ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
