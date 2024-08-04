import 'package:leechineo_panel/core/data/entities/pagination_entity_impl.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/options_selector/options_selector_data.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/options_selector/options_selector_methods.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/product/domain/usecases/get_products_usecase.dart';

class OptionsSelectorController<V>
    extends AppController<OptionsSelectorData, OptionsSelectorMethods> {
  late final GetProductsUseCase _getProductsUseCase;
  OptionsSelectorController({
    required GetProductsUseCase getProductsUseCase,
  }) {
    _getProductsUseCase = getProductsUseCase;
    methods.loadProducts();
  }

  @override
  OptionsSelectorMethods defineMethods() {
    return OptionsSelectorMethods(
      loadProducts: ({dataRequest}) async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          final paginatedProduct = await _getProductsUseCase(
            dataRequest: dataRequest,
          );
          updateData(
            data.copyWith(
              products: paginatedProduct.items,
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
    );
  }

  @override
  OptionsSelectorData defineData() {
    return OptionsSelectorData(
      loading: true,
      products: [],
      selectedProducts: [],
      pagination: PaginationArgsImpl(
        limit: 10,
        page: 1,
      ),
    );
  }
}
