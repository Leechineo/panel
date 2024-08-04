import 'package:leechineo_panel/core/presenter/components/product_options_selector/domain/entities/option_shipping_entitiy.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/options_selector/options_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/presentation/controllers/product_options_selector/product_options_selector_data.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/presentation/controllers/product_options_selector/product_options_selector_methods.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';
import 'package:leechineo_panel/features/product/domain/usecases/get_products_usecase.dart';
import 'package:leechineo_panel/features/shipping_method/data/entities/shipping_method_entity_impl.dart';
import 'package:leechineo_panel/features/shipping_method/domain/usecases/calculate_shipping_usecase.dart';
import 'package:leechineo_panel/features/shipping_method/domain/usecases/get_all_shipping_methods_usecase.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/get_all_stocks_usecase.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/get_stock_by_id_usecase.dart';

class ProductSelectorController<V>
    extends AppController<ProductSelectorData, ProductSelectorMethods> {
  late final OptionsSelectorController optionsSelectorController;
  late final GetAllStocksUseCase _getAllStocksUseCase;
  late final GetStockByIdUseCase _getStockByIdUseCase;
  late final GetAllShippingMethodsUseCase _getAllShippingMethodsUseCase;
  late final CalculateShippingUseCase _calculateShippingUseCase;

  final GetProductsUseCase getProductsUseCase;
  final GetAllStocksUseCase getAllStocksUseCase;

  ProductSelectorController({
    required GetStockByIdUseCase getStockByIdUseCase,
    required GetAllShippingMethodsUseCase getAllShippingMethodsUseCase,
    required CalculateShippingUseCase calculateShippingUseCase,
    required this.getAllStocksUseCase,
    required this.getProductsUseCase,
  }) {
    _getAllStocksUseCase = getAllStocksUseCase;
    _getStockByIdUseCase = getStockByIdUseCase;
    _getAllShippingMethodsUseCase = getAllShippingMethodsUseCase;
    _calculateShippingUseCase = calculateShippingUseCase;

    optionsSelectorController = OptionsSelectorController(
      getProductsUseCase: getProductsUseCase,
    );
  }

  @override
  ProductSelectorMethods defineMethods() {
    return ProductSelectorMethods(
      findStockShipping: (stock) {
        final itemsFromStock = data.selectedItems.where(
          (element) => element.stockId == stock.id,
        );
        final variantsWithShippingMethod = itemsFromStock.where(
          (element) =>
              methods.findProductShipping(element.id, stock.shippingMethod) !=
              null,
        );
        final variantsWithoutShippingMethod = itemsFromStock.where(
          (element) => !variantsWithShippingMethod.contains(element),
        );
        final availableShippingMethods = variantsWithShippingMethod
            .map(
              (e) =>
                  methods
                      .findProductShipping(e.id, stock.shippingMethod)
                      ?.shippingMethodId ??
                  '',
            )
            .where((element) => element.isNotEmpty)
            .toSet();
        if (availableShippingMethods.length == 1 &&
            variantsWithoutShippingMethod.isEmpty) {
          return methods.findProductShipping(
            variantsWithShippingMethod.first.id,
            stock.shippingMethod,
          );
        }
        final filteredMappings = data.stockShippingMappings.where(
          (element) => element.shippingMethodId == stock.shippingMethod,
        );
        if (filteredMappings.isNotEmpty) {
          return filteredMappings.first;
        }
        return null;
      },
      updadeShippingMappings: () async {
        final List<OptionShippingEntity> mappings = [];
        for (final stock in data.stocks) {
          if (data.addressId != null && data.addressId!.isNotEmpty) {
            final mapping = await _calculateShippingUseCase(
              addressId: data.addressId!,
              shippingMethodId: stock.shippingMethod,
            );
            if (mapping != null) {
              mappings.add(
                OptionShippingEntity(
                  shippingMethodId: stock.shippingMethod,
                  shippingMethodMapping: mapping,
                ),
              );
            }
          }
        }
        updateData(
          data.copyWith(
            stockShippingMappings: mappings,
          ),
        );
      },
      updadeShippingProductMappings: () async {
        try {
          final List<OptionShippingEntity> shippingMappings = [];
          for (final stock in data.stocks) {
            final shippingMethodFiltered = data.shippingMethods.where(
              (element) => element.id == stock.shippingMethod,
            );
            if (shippingMethodFiltered.isEmpty) {
              return;
            }
            final shippingMethod = shippingMethodFiltered.first;
            final productIds =
                shippingMethod.products.map((e) => e.id).toList();
            for (final id in productIds) {
              if (data.addressId != null && data.addressId!.isNotEmpty) {
                final mapping = await _calculateShippingUseCase(
                  addressId: data.addressId!,
                  shippingMethodId: stock.shippingMethod,
                  productId: id,
                );
                if (mapping != null) {
                  shippingMappings.add(
                    OptionShippingEntity(
                      productId: id,
                      shippingMethodId: stock.shippingMethod,
                      shippingMethodMapping: mapping,
                    ),
                  );
                }
              }
            }
          }
          updateData(
            data.copyWith(
              productShippingMappings: shippingMappings,
            ),
          );
        } catch (e) {
          catchError(e);
        }
      },
      findProductShipping: (productId, shippingMethodId) {
        final shippingFiltered = data.productShippingMappings.where(
          (element) =>
              element.productId == productId &&
              element.shippingMethodId == shippingMethodId,
        );
        if (shippingFiltered.isNotEmpty) {
          final productShipping = shippingFiltered.first;
          return productShipping;
        }
        return null;
      },
      addSelectedItem: (item) {
        if (data.selectedItems
            .where(
              (element) => element.option.id == item.option.id,
            )
            .isEmpty) {
          updateData(
            data.copyWith(
              selectedItems: data.selectedItems..add(item),
            ),
          );
        } else {
          final OrderItemImpl existingItem = data.selectedItems.firstWhere(
            (element) => element.option.id == item.option.id,
          );
          final int index = data.selectedItems.indexOf(existingItem);
          final selectedItemsCopy = [...data.selectedItems];
          selectedItemsCopy[index] = selectedItemsCopy[index].copyWith(
            quantity: selectedItemsCopy[index].quantity + item.quantity,
          );
          updateData(
            data.copyWith(
              selectedItems: selectedItemsCopy,
            ),
          );
        }
        methods.updateStocks();
      },
      deleteItem: (item) {
        final selectedItemsCopy = List<OrderItemImpl>.from(data.selectedItems);
        final indexToRemove = selectedItemsCopy.indexWhere(
          (element) => element.option.id == item.option.id,
        );
        if (indexToRemove != -1) {
          selectedItemsCopy.removeAt(indexToRemove);
          updateData(
            data.copyWith(
              selectedItems: selectedItemsCopy,
            ),
          );
        }
        methods.updateStocks();
      },
      updateItems: (items) {
        final List<OrderItemImpl> updatedItems = [];
        for (OrderItemImpl item in data.selectedItems) {
          if (items
              .where((element) => element.option.id == item.option.id)
              .isNotEmpty) {
            final OrderItemImpl updatedItem = items
                .firstWhere((element) => element.option.id == item.option.id);
            updatedItems.add(updatedItem);
          } else {
            updatedItems.add(item);
          }
        }
        updateData(
          data.copyWith(
            selectedItems: updatedItems,
          ),
        );
        methods.updateStocks();
      },
      updateStocks: () async {
        final List<StockEntity> stocksAdded = [];
        final currentStocks = await _getAllStocksUseCase();
        if (currentStocks.isNotEmpty) {
          for (final OrderItemImpl orderItem in data.selectedItems) {
            final StockEntity stock = await _getStockByIdUseCase(
              orderItem.stockId,
            );
            if (stocksAdded
                .where((element) => element.id == stock.id)
                .isEmpty) {
              stocksAdded.add(stock);
            }
          }
        }
        updateData(
          data.copyWith(
            stocks: stocksAdded,
          ),
        );
        await methods.updateShippingMethods();
        await methods.updadeShippingProductMappings();
        await methods.updadeShippingMappings();
      },
      updateShippingMethods: () async {
        final shippingMethods = await _getAllShippingMethodsUseCase();
        updateData(
          data.copyWith(
            shippingMethods: shippingMethods
                .map(
                  (e) => ShippingMethodEntityImpl(
                    id: e.id,
                    name: e.name,
                    defaultMapping: e.defaultMapping,
                    mappings: e.mappings,
                    products: e.products,
                    createdAt: e.createdAt,
                  ),
                )
                .toList(),
          ),
        );
      },
      defineAddressId: (String? addressId) {
        updateData(
          data.copyWith(
            addressId: addressId,
          ),
        );
      },
    );
  }

  @override
  ProductSelectorData defineData() {
    return ProductSelectorData(
      selectedItems: [],
      stocks: [],
      shippingMethods: [],
      addressId: null,
      productShippingMappings: [],
      stockShippingMappings: [],
    );
  }
}
