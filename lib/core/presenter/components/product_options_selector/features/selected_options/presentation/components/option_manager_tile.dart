import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leechineo_panel/core/data/models/currency_model.dart';
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/widgets/product_option_images.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';

class OptionManagerTile extends StatefulWidget {
  final OrderItemImpl item;
  final OrderItemImpl originalItem;
  final void Function(OrderItemImpl item) onDeleted;
  final void Function(OrderItemImpl item) onUpdated;
  final bool expanded;
  final GetFileUrlUseCase getFileUrlUseCase;
  final ShippingMethodMapping? shippingMapping;
  const OptionManagerTile({
    required this.item,
    required this.originalItem,
    required this.onDeleted,
    required this.onUpdated,
    required this.getFileUrlUseCase,
    this.shippingMapping,
    this.expanded = true,
    super.key,
  });

  @override
  State<OptionManagerTile> createState() => _OptionManagerTileState();
}

class _OptionManagerTileState extends State<OptionManagerTile> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  late final CurrencyEnum currency;

  @override
  void initState() {
    super.initState();
    if (quantityController.text.isEmpty) {
      quantityController.text = widget.item.quantity.toString();
    }
    if (priceController.text.isEmpty) {
      priceController.text = widget.item.option.price.toString();
    }
    currency = widget.item.currency;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      contentPadding: const EdgeInsets.all(12),
      childExpanded: widget.expanded,
      borderless: !widget.expanded && widget.shippingMapping == null,
      actions: widget.expanded
          ? [
              FilledButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: AppCard(
                          width: 250,
                          height: 100,
                          titleText: 'Deseja deletar o item?',
                          actions: [
                            FilledButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                                widget.onDeleted(widget.item);
                              },
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Colors.red,
                                ),
                              ),
                              child: const Text(
                                'Apagar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.red,
                  ),
                ),
                child: const Text(
                  'Apagar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ]
          : null,
      title: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (widget.item.images.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: AppCard(
                                width: 400,
                                contentPadding: const EdgeInsets.all(12),
                                actions: [
                                  FilledButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Fechar'),
                                  ),
                                ],
                                child: Center(
                                  child: ProductOptionImages(
                                    images: widget.item.images,
                                    getFileUrlUseCase: widget.getFileUrlUseCase,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Image.network(
                        widget.getFileUrlUseCase(widget.item.images[0]),
                        width: 60,
                      ),
                    ),
                  ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    widget.item.option.variant.isEmpty
                        ? 'Variante única'
                        : widget.item.option.variant.join(' • '),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                if (!widget.expanded)
                  Column(
                    children: [
                      Text('${widget.item.quantity} unidades'),
                      Text(
                        CurrencyModel.newWith(
                          code: widget.item.currency,
                          value:
                              widget.item.option.price * widget.item.quantity,
                        ).format(),
                      ),
                    ],
                  ),
              ],
            ),
            if (widget.shippingMapping != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: AppCard(
                  color: Colors.green,
                  borderless: true,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Estimativa:'),
                            Text(
                                'De ${widget.shippingMapping!.arriveTime.min} à ${widget.shippingMapping!.arriveTime.max} dias')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Preço:'),
                            Builder(
                              builder: (context) {
                                final currency =
                                    widget.shippingMapping!.price.currency ==
                                            CurrencyEnum.brl
                                        ? 'R\$'
                                        : '\$';
                                return Text(
                                    '$currency${widget.shippingMapping!.price.value.toStringAsFixed(2).replaceAll('.', ',')}');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            controller: quantityController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              String updatedValue = value;
              if (value.isEmpty || value == '0') {
                updatedValue = '1';
              }
              if (int.tryParse(updatedValue) is int) {
                widget.onUpdated(
                  widget.item.copyWith(
                    quantity: int.tryParse(updatedValue),
                  ),
                );
              }
            },
            decoration: InputDecoration(
              prefixIcon: Tooltip(
                message:
                    'Restaurar quantidade original (${widget.originalItem.quantity})',
                child: IconButton(
                  onPressed: () {
                    quantityController.text =
                        widget.originalItem.quantity.toString();
                    widget.onUpdated(
                      widget.item.copyWith(
                        quantity: widget.originalItem.quantity,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings_backup_restore_rounded,
                  ),
                ),
              ),
              // suffix: Text('Estoque: ${widget.originalItem.option.}'),
              labelText: 'Quantidade',
              border: const OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: DropdownButtonFormField(
                  value: widget.item.currency,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    // prefixIcon: Tooltip(
                    //   message:
                    //       'Restaurar moeda original (${widget.originalItem.currency})',
                    //   child: IconButton(
                    //     onPressed: () {
                    //       widget.onUpdated(
                    //         widget.item.copyWith(
                    //           currency: widget.originalItem.currency,
                    //         ),
                    //       );
                    //     },
                    //     icon: const Icon(
                    //       Icons.settings_backup_restore_rounded,
                    //     ),
                    //   ),
                    // ),
                    labelText: 'Moeda',
                    isDense: true,
                  ),
                  items: currencies.map((currency) {
                    return DropdownMenuItem<CurrencyEnum>(
                      value: currency,
                      child: Builder(
                        builder: (context) {
                          if (currency == CurrencyEnum.brl) {
                            return const Text('Real');
                          }
                          return const Text('Dólar');
                        },
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value is String) {
                      widget.onUpdated(
                        widget.item.copyWith(
                          currency: value,
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d*'),
                    ),
                  ],
                  onChanged: (value) {
                    String updatedValue = value;
                    if (value.isEmpty || value == '0') {
                      updatedValue = '1';
                    }
                    if (double.tryParse(updatedValue) is double) {
                      widget.onUpdated(
                        widget.item.copyWith(
                          option: widget.item.option.copyWith(
                            price: double.tryParse(updatedValue),
                          ),
                        ),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Tooltip(
                      message:
                          'Restaurar preço original (${widget.originalItem.option.price})',
                      child: IconButton(
                        onPressed: () {
                          priceController.text =
                              widget.item.option.price.toString();
                          widget.onUpdated(
                            widget.item.copyWith(
                              option: widget.item.option.copyWith(
                                price: widget.originalItem.option.price,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.settings_backup_restore_rounded,
                        ),
                      ),
                    ),
                    labelText: 'Preço',
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const List<CurrencyEnum> currencies = [CurrencyEnum.usd, CurrencyEnum.brl];
