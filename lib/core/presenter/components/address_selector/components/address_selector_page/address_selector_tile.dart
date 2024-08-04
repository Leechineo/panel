import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';

class AddressSelectorTile extends StatelessWidget {
  final AddressEntityImpl address;
  final bool selected;
  final void Function(AddressEntityImpl address)? onToggleSelection;
  const AddressSelectorTile({
    required this.address,
    this.onToggleSelection,
    this.selected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggleSelection != null
          ? () {
              onToggleSelection?.call(address);
            }
          : null,
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
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.my_location_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${address.city}-${address.state}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  address.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${address.street} - ${address.number}, ${address.district}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  address.zipcode,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
