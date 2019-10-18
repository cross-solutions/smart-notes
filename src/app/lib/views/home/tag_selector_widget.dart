import 'package:app/models/notes/tag_item_model.dart';
import 'package:app/views/home/tag_button.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TagSelectorWidget extends StatelessWidget {
  TagSelectorWidget({
    Key key,
    @required this.items,
    @required this.selectedItems,
    @required this.onSelectedItemsChanged,
  }) : super(key: key);

  final List<TagItemModel> items;
  final List<TagItemModel> selectedItems;
  final void Function(List<TagItemModel> newItems) onSelectedItemsChanged;

  @override
  Widget build(BuildContext context) {
    return ExtendedRow(
      mainAxisSize: MainAxisSize.min,
      spacing: 12.0,
      children: items.map((t) {
        final isSelected = selectedItems.contains(t);
        return TagButton(
          child: Text(t.text),
          isSelected: isSelected,
          onSelectedChanged: (s) {
            if (isSelected)
              onSelectedItemsChanged(selectedItems..remove(t));
            else
              onSelectedItemsChanged(selectedItems..add(t));
          },
        );
      }).toList(),
    );
  }
}
