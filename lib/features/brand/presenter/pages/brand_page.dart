import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_flex.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/brand/presenter/controllers/brand_page_controller/brand_page_controller.dart';
import 'package:leechineo_panel/features/brand/presenter/widgets/brand_tile.dart';

class BrandPage extends StatelessWidget {
  final BrandPageController brandsPageController;

  const BrandPage({
    required this.brandsPageController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 12, 12),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            brandsPageController.methods.goToBrandsEditorPage('null');
          },
          child: const Icon(Icons.add_rounded),
        ),
        body: brandsPageController.builder(
          builder: (context, data) {
            if (data.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (data.brands.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppIlustration(
                      AppIlustrations.watchApplication,
                      width: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Sem marcas',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    FilledButton(
                      onPressed: () {},
                      child: const Text('Adicionar'),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: AppFlex(
                maxItemsPerRow: 1,
                maxItemsPerRowSm: 2,
                maxItemsPerRowMd: 3,
                maxItemsPerRowLg: 4,
                wrap: true,
                children: data.brands.map((brand) {
                  return BrandTile(
                    brand: brand,
                    editable: true,
                    getUrl: (fileId) {
                      final url =
                          brandsPageController.methods.getFileUrl(fileId);
                      return url;
                    },
                    onEditorRequested: (id) {
                      brandsPageController.methods.goToBrandsEditorPage(id);
                    },
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
