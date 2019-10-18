import 'package:flutter/material.dart';

class TagButton extends StatelessWidget {
  TagButton({
    Key key,
    @required this.child,
    @required this.onSelectedChanged,
    this.isSelected = false,
  }) : super(key: key);

  final Widget child;
  final bool isSelected;
  final void Function(bool isSelected) onSelectedChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelectedChanged(!isSelected),
      child: AnimatedContainer(
        constraints: BoxConstraints(minWidth: 72.0, maxHeight: 48.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        duration: Duration(milliseconds: 150),
        curve: Curves.easeInOutQuad,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          gradient: isSelected
              ? LinearGradient(colors: <Color>[
                  Color(0xFFFE8c00),
                  Color(0xFFF83600),
                ])
              : LinearGradient(
                  colors: <Color>[
                    Colors.grey[200],
                    Colors.grey[100],
                  ],
                ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
