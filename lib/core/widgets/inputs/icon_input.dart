import 'package:animations/animations.dart';
import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';
import 'package:habit_go/core/widgets/icons/icons_list.dart';

class IconInput extends StatefulWidget {
  final String? iconName;
  final String? id;

  const IconInput({
    this.iconName,
    this.id,
    super.key,
  });

  @override
  State<IconInput> createState() => _IconInputState();
}

class _IconInputState extends State<IconInput> {
  String iconName = '';
  late IconData _selectedIcon;

  @override
  void initState() {
    if (widget.iconName != null) {
      iconName = widget.iconName!;
      _selectedIcon =
          FeatherIcons.icons[widget.iconName] ?? FeatherIcons.fi_clipboard;
    } else {
      iconName = 'clipboard';
      _selectedIcon = FeatherIcons.fi_clipboard;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DataFormField(
      id: widget.id ?? '',
      value: iconName,
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        closedElevation: 0,
        closedBuilder: (context, openMenu) {
          return Material(
            borderRadius: BorderRadius.circular(8),
            color: context.theme.canvasColor,
            child: InkWell(
              onTap: () {
                openMenu();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: context.theme.canvasColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.themeColors.grey,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  _selectedIcon,
                  color: context.theme.primaryColor,
                ),
              ),
            ),
          );
        },
        openBuilder: (context, closeMenu) {
          return IconsList(
            onTap: (icon) {
              iconName = icon;
              Navigator.of(context).pop();
              setState(() {
                _selectedIcon =
                    FeatherIcons.icons[icon] ?? FeatherIcons.fi_clipboard;
              });
            },
          );
        },
      ),
    );
  }
}
