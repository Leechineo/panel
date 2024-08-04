import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_image.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

class BrandTile extends StatelessWidget {
  final BrandEntity brand;
  final void Function(String id)? onEditorRequested;
  final bool editable;
  final bool? dark;
  final String Function(String fileId) getUrl;
  const BrandTile({
    required this.brand,
    required this.editable,
    required this.getUrl,
    this.onEditorRequested,
    this.dark,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        dark ?? MediaQuery.of(context).platformBrightness == Brightness.dark;
    return AppCard(
      color: isDark ? brand.color.dark : brand.color.light,
      width: 280,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isDark
                          ? brand.icon.dark.isNotEmpty
                          : brand.icon.light.isNotEmpty)
                        AppImage.svgNetwork(
                          getUrl(isDark ? brand.icon.dark : brand.icon.light),
                          width: 70,
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    brand.name,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: _getTextColor(
                            isDark ? brand.color.dark : brand.color.light,
                          ),
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          if (editable)
            Positioned(
              top: 4,
              left: 4,
              child: AppCard(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_rounded,
                      ),
                    ),
                    IconButton(
                      onPressed: () => onEditorRequested?.call(brand.id),
                      icon: const Icon(
                        Icons.edit_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Color _getTextColor(Color backgroundColor) {
  double luminance = backgroundColor.computeLuminance();

  return luminance > 0.5 ? Colors.black : Colors.white;
}
