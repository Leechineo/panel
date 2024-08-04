import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/compound_variant_selector/compound_variant_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/product_variant_selector/product_variant_selector_data.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/product_variant_selector/product_variant_selector_methods.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/order/domain/entities/order_entity.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/product/domain/enums/product_variants_type_enum.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/get_all_stocks_usecase.dart';

class ProductVariantSelectorController<V> extends AppController<
    ProductVariantSelectorData, ProductVariantSelectorMethods> {
  final ProductEntity product;
  late final GetAllStocksUseCase _getAllStocksUseCase;
  CompoundVariantSelectorController? compoundVariantSelectorController;

  ProductVariantSelectorController({
    required GetAllStocksUseCase getAllStocksUseCase,
    required this.product,
  }) {
    _getAllStocksUseCase = getAllStocksUseCase;
    methods.loadStocks();
  }

  @override
  ProductVariantSelectorMethods defineMethods() {
    return ProductVariantSelectorMethods(
      loadStocks: () async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          final stocks = await _getAllStocksUseCase(refresh: true);
          updateData(
            data.copyWith(
              stocks: stocks,
            ),
          );
        } catch (error) {
          catchError(error);
        }
        updateData(
          data.copyWith(
            loading: false,
          ),
        );
      },
      getStocksFromProduct: () {
        final Iterable<String> validStocksId = data.stocks.map((e) => e.id);
        final Iterable<String> productStocks = product.stocks
            .map((e) => e.stock)
            .where((stockId) => validStocksId.contains(stockId));
        final validStocks = data.stocks
            .where((stock) => productStocks.contains(stock.id))
            .toList();
        return validStocks;
      },
      updateSelectedStock: (stockId) {
        if (stockId == null) {
          updateData(
            data.copyWith(
              selectedStock: null,
              clearStock: true,
            ),
          );
          methods.setCompoundVariantSelectorController();
          return null;
        } else {
          final StockEntity stock =
              data.stocks.firstWhere((element) => element.id == stockId);
          updateData(
            data.copyWith(
              selectedStock: stock,
            ),
          );
          methods.setCompoundVariantSelectorController();
          return stock;
        }
      },
      getProductStockFromStock: (stock) {
        final productStock =
            product.stocks.firstWhere((element) => element.stock == stock.id);
        return productStock;
      },
      updateSelectedVariantsOption: (option) {
        updateData(
          data.copyWith(
            selectedOption: option,
            clearOption: option == null,
            quantity: 1,
          ),
        );
      },
      setCompoundVariantSelectorController: () {
        final ProductVariantsTypeEnum? selectedVariantType =
            data.selectedStock != null
                ? methods
                    .getProductStockFromStock(data.selectedStock!)
                    .variants
                    .type
                : null;
        final ProductStock? selectedProductStock = data.selectedStock != null
            ? methods.getProductStockFromStock(data.selectedStock!)
            : null;
        if (selectedVariantType == ProductVariantsTypeEnum.compound) {
          compoundVariantSelectorController = CompoundVariantSelectorController(
            options: selectedProductStock!.variants.options!,
            properties: selectedProductStock.variants.properties,
          );
        }
      },
      updateQuantity: (quantity) {
        updateData(
          data.copyWith(
            quantity: quantity,
          ),
        );
      },
      getAvailableQuantity: (option, selectedItems) {
        if (option != null) {
          final bool isItemAdded = selectedItems
              .where(
                (element) => element.option.id == option.id,
              )
              .isNotEmpty;
          if (isItemAdded) {
            final OrderItem orderItem = selectedItems.firstWhere(
              (element) => element.option.id == option.id,
            );
            return (option.instock - orderItem.quantity).toDouble();
          } else {
            return option.instock.toDouble();
          }
        }
        return 1;
      },
    );
  }

  @override
  ProductVariantSelectorData defineData() {
    return ProductVariantSelectorData(
      loading: true,
      stocks: [],
      selectedStock: null,
      selectedOption: null,
      quantity: 1,
    );
  }
}
