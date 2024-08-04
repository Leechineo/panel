import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/presenter/widgets/brand_tile.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';

class BrandPreview extends StatelessWidget {
  final bool dark;
  final BrandEntity brand;
  final Future<List<FileReferenceEntity>?> Function() selector;
  final void Function(FileReferenceEntity icon)? onIconSelected;
  final void Function() onIconMirror;
  final String Function(String fileId) getUrl;
  const BrandPreview({
    required this.brand,
    required this.selector,
    required this.onIconMirror,
    required this.getUrl,
    this.onIconSelected,
    this.dark = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      actions: [
        if ((dark && brand.icon.dark.isNotEmpty) ||
            (!dark && brand.icon.light.isNotEmpty))
          FilledButton(
            onPressed: () {
              onIconMirror();
            },
            child: const Text('Espelhar ícone'),
          ),
        FilledButton(
          onPressed: () async {
            final List<FileReferenceEntity>? icon = await selector();
            if (icon != null && icon.isNotEmpty) {
              onIconSelected?.call(icon[0]);
            }
          },
          child: const Text(
            'Selecionar ícone',
          ),
        )
      ],
      child: Column(
        children: [
          Container(
            color: dark ? Colors.black12 : Colors.grey[200],
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 4,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/Ilustrations/app/logo.svg',
                  width: 50,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: dark ? Colors.white10 : Colors.grey[300],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    child: Text(
                      'Buscar...',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const CircleAvatar(
                  child: Text('A'),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  color: dark ? Colors.black.withOpacity(.3) : Colors.white,
                  child: Center(
                    child: BrandTile(
                      getUrl: (fileId) {
                        return getUrl(fileId);
                      },
                      brand: brand,
                      editable: false,
                      dark: dark,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
