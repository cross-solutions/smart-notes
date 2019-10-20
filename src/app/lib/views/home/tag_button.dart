import 'package:app/resources/resources.dart';
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
        constraints: BoxConstraints(minWidth: 72.0, maxHeight: 36.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        duration: Duration(milliseconds: 150),
        curve: Curves.easeInOutQuad,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          border: Border(),
          gradient: isSelected
              ? AppGradients.orangeAccent
              : AppGradients.lightGray,
        ),
        child: Center(child: child),
      ),
    );
  }
}
