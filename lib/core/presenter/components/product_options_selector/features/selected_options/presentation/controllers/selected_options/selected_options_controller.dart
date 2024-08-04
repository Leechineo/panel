import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/controllers/selected_options/selected_options_data.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/controllers/selected_options/selected_options_methods.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/order/domain/entities/order_entity.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/product/domain/usecases/get_products_usecase.dart';

class SelectedOptionsController<V>
    extends AppController<SelectedOptionsData, SelectedOptionsMethods> {
  final List<OrderItem> selectedItems;
  late final GetProductsUseCase _getProductsUseCase;

  SelectedOptionsController({
    required this.selectedItems,
    required GetProductsUseCase getProductsUseCase,
  }) {
    _getProductsUseCase = getProductsUseCase;
    methods.loadProducts();
  }

  @override
  SelectedOptionsMethods defineMethods() {
    return SelectedOptionsMethods(
      loadProducts: ({dataRequest}) async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          final paginatedProducts = await _getProductsUseCase(
            dataRequest: dataRequest,
          );
          updateData(
            data.copyWith(
              products: paginatedProducts.items,
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
      setProductsFromSelectedItems: (items) {
        final List<ProductEntity> products = [];
        for (OrderItem item in items) {
          final filteredProduct = data.products.where(
            (element) => element.id == item.id,
          );
          if (filteredProduct.isNotEmpty) {
            final ProductEntity product = filteredProduct.first;
            if (!products.contains(product)) {
              products.add(product);
            }
          }
        }
        updateData(
          data.copyWith(
            selectedProducts: products,
          ),
        );
      },
    );
  }

  @override
  SelectedOptionsData defineData() {
    return SelectedOptionsData(
      products: [],
      selectedProducts: [],
      loading: false,
    );
  }
}
