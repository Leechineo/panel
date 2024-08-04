import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/data/models/currency_model.dart';
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/widgets/product_option_images.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/product/domain/enums/product_variants_type_enum.dart';

class ProductVariantsOptionTile extends StatelessWidget {
  final ProductVariantsOption option;
  final ProductVariantsTypeEnum type;
  final CurrencyEnum currency;
  final GetFileUrlUseCase getFileUrlUseCase;
  const ProductVariantsOptionTile({
    required this.option,
    required this.type,
    required this.currency,
    required this.getFileUrlUseCase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (option.images != null && option.images!.isNotEmpty)
          Column(
            children: [
              ProductOptionImages(
                images: option.images!,
                getFileUrlUseCase: getFileUrlUseCase,
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        AppCard(
          borderRadius: BorderRadius.circular(12),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Em estoque:',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(option.instock.toString()),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                ),
                child: AppDivider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Preço ($currency):',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      CurrencyModel.newWith(
                        code: currency,
                        value: option.price,
                      ).format(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
