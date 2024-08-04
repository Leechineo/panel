import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_flex.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart';

class ElementPicker extends StatelessWidget {
  final void Function(Elements elementType) onSelected;
  const ElementPicker({
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      titleText: 'Adicionar elemento',
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        )
      ],
      width: 900,
      height: 360,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppFlex(
            wrap: true,
            maxItemsPerRow: 1,
            maxItemsPerRowMd: 4,
            children: [
              AppCard(
                onTap: () {
                  onSelected(Elements.row);
                  Navigator.pop(context);
                },
                titleText: 'Linha',
                child: SizedBox(
                  height: 150,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: AppCard(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppDivider(
                              vertical: true,
                              height: 30,
                            ),
                            AppDivider(
                              vertical: true,
                              height: 30,
                            ),
                            AppDivider(
                              vertical: true,
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AppCard(
                titleText: 'Coluna',
                onTap: () {
                  onSelected(Elements.column);
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 150,
                  child: Center(
                    child: AppCard(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                      width: 50,
                      height: 120,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppDivider(),
                          AppDivider(),
                          AppDivider(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AppCard(
                titleText: 'Container',
                onTap: () {
                  onSelected(Elements.container);
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 150,
                  child: Center(
                    child: AppCard(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      width: 150,
                      child: const SizedBox(
                        height: 100,
                      ),
                    ),
                  ),
                ),
              ),
              AppCard(
                titleText: 'Imagem',
                onTap: () {
                  onSelected(Elements.image);
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 150,
                  child: Center(
                    child: AppCard(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      width: 150,
                      height: 100,
                      child: const Icon(Icons.image),
                    ),
                  ),
                ),
              ),
              AppCard(
                titleText: 'Texto',
                onTap: () {
                  onSelected(Elements.text);
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 150,
                  child: Center(
                    child: AppCard(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      width: 150,
                      height: 100,
                      child: const Icon(Icons.format_shapes),
                    ),
                  ),
                ),
              ),
              AppCard(
                titleText: 'Link',
                onTap: () {
                  onSelected(Elements.link);
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 150,
                  child: Center(
                    child: AppCard(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      width: 150,
                      height: 100,
                      child: const Icon(Icons.link),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
