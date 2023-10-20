import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';
import 'package:habit_go/core/widgets/inputs/text_input.dart';

class IconsList extends StatefulWidget {
  final Function(String)? onLongTap;
  final Function(String)? onTap;

  const IconsList({
    this.onLongTap,
    this.onTap,
    super.key,
  });

  @override
  State<IconsList> createState() => _IconsListState();
}

class _IconsListState extends State<IconsList> {
  late List<String> labelsFull;
  late List<String> labels;
  late List<IconData> icons;

  Timer? _debounce;

  @override
  void initState() {
    labelsFull = switch (Platform.localeName) {
      'pt_BR' || 'pt' => FeatherIcons.iconsPT.keys.toList(),
      _ => FeatherIcons.icons.keys.toList(),
    };
    labels = labelsFull;
    icons = FeatherIcons.icons.values.toList();
    super.initState();
  }

  String _getSelectedIcon(int index) {
    return switch (Platform.localeName) {
      'pt_BR' || 'pt' => FeatherIcons.iconsPT[labels[index]] ?? 'clipboard',
      _ => labels[index],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.canvasColor,
      appBar: AppBar(
        backgroundColor: context.theme.canvasColor,
        title: Text(
          'Select an icon',
          style: context.text.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextInput(
              leadingIcon: Icons.search,
              autoFocus: false,
              placeholder: 'Search',
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 400), () {
                  setState(() {
                    if (value.isEmpty) {
                      labels = labelsFull;
                    }
                    labels = labelsFull
                        .where((element) => element.contains(value))
                        .toList();
                  });
                });
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: labels.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      FeatherIcons.icons[_getSelectedIcon(index)],
                      color: context.theme.primaryColor,
                    ),
                    title: Text(
                      labels[index],
                      style: context.text.bodyMedium,
                    ),
                    onTap: () {
                      widget.onTap?.call(_getSelectedIcon(index));
                    },
                    onLongPress: () {
                      widget.onLongTap?.call(_getSelectedIcon(index));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
