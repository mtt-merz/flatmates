import 'package:flatmates/app/models/flat/common_space/common_space.dart';
import 'package:flatmates/app/ui/screens/flat/flat_common_space_widget.dart';
import 'package:flatmates/app/ui/widget/form_dialog.dart';
import 'package:flutter/material.dart';

class SetCommonSpacesDialog extends StatelessWidget {
  final List<CommonSpace> commonSpaces = [];

  SetCommonSpacesDialog(List<CommonSpace> commonSpaces, {Key? key}) : super(key: key) {
    this.commonSpaces.addAll(commonSpaces);
  }

  @override
  Widget build(BuildContext context) => FormDialog(
        title: 'Common spaces',
        children: defaultCommonSpaces
            .map((space) => CommonSpaceWidget(
                  title: space.name,
                  backgroundColor: space.color,
                  // initiallySelected: commonSpaces.contains(space),
                  // onTap: (value) =>
                  //     value ? commonSpaces.add(space) : commonSpaces.remove(space),
                ))
            .toList(),
        onSubmit: () => Navigator.of(context).pop(commonSpaces),
        onCancel: Navigator.of(context).pop,
      );
}
