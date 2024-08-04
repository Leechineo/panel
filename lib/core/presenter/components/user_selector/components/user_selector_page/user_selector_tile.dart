import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class UserSelectorTile extends StatelessWidget {
  final UserEntityImpl user;
  final bool selected;
  final void Function(UserEntityImpl user) onSelected;

  const UserSelectorTile({
    required this.user,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(user),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            AnimatedOpacity(
              opacity: selected ? 1 : 0,
              duration: const Duration(
                milliseconds: 80,
              ),
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 80,
                ),
                curve: Curves.easeInOut,
                width: selected ? 25 : 0,
                child: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).buttonTheme.colorScheme!.primary,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            CircleAvatar(
              child: Text('${user.name[0]}${user.surname[0]}'),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name} ${user.surname}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  if (user.admin)
                    const SizedBox(
                      width: 4,
                    ),
                  if (user.admin)
                    Icon(
                      Icons.shield_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 12,
                    ),
                ],
              ),
            ),
            Text(
              user.email,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
