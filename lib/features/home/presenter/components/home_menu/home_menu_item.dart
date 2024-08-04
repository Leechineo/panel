import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/home/domain/entities/home_menu_list_item_entity.dart';

class HomeMenuItem extends StatelessWidget {
  final HomeMenuListItemEntity homeMenuListItem;
  final bool active;
  final void Function(HomeMenuListItemEntity item) onItemSelected;
  const HomeMenuItem({
    required this.homeMenuListItem,
    required this.onItemSelected,
    this.active = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onItemSelected(homeMenuListItem),
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(.1),
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: active
              ? Theme.of(context).colorScheme.primary.withOpacity(.1)
              : null,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Icon(
              homeMenuListItem.icon,
              color: active
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primary.withOpacity(.8),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(homeMenuListItem.title),
          ],
        ),
      ),
    );
  }
}
