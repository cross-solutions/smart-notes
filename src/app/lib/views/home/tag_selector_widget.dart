import 'package:app/models/notes/tag_item_model.dart';
import 'package:app/views/home/tag_button.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TagSelectorWidget extends StatelessWidget {
  TagSelectorWidget({Key key, @required this.items}) : super(key: key);

  final List<TagItemModel> items;

  @override
  Widget build(BuildContext context) {
    return ExtendedRow(
      mainAxisSize: MainAxisSize.min,
      spacing: 12.0,
      children: items.map(
        (t) {
          return ScopedModel<TagItemModel>(
            model: t,
            child: ScopedModelDescendant<TagItemModel>(
              builder: (context, _, model) {
                return TagButton(
                  child: Text(
                    t.name,
                    style: TextStyle().copyWith(color: Colors.black87, fontWeight: FontWeight.w600),
                  ),
                  isSelected: model.isSelected,
                  onSelectedChanged: (isSelected) => model.isSelected = isSelected,
                );
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
