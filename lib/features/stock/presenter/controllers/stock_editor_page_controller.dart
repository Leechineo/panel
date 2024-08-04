import 'package:flutter/widgets.dart';
import 'package:leechineo_panel/core/domain/enums/country_enum.dart';
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/core/domain/errors/app_error.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/usecases/get_all_shipping_methods_usecase.dart';
import 'package:leechineo_panel/features/stock/data/entities/stock_entity_impl.dart';
import 'package:leechineo_panel/features/stock/domain/dtos/create_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/dtos/update_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/create_stock_usecase.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/get_stock_by_id_usecase.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/update_stock_usecase.dart';
import 'package:leechineo_panel/features/stock/presenter/events/load_stocks_event.dart';

class StocksEditorPageForm {
  final StockEntity stock;

  late TextEditingController nameController;

  StocksEditorPageForm(this.stock) {
    nameController = TextEditingController();

    nameController.text = stock.name;
  }
}

class StocksEditorPageData {
  final StockEntity stock;
  final StockEntityImpl editStock;
  final List<ShippingMethodEntity> shippingMethods;
  final List<StocksEditorPageDataCountry> countries;
  final List<StocksEditorPageDataCurrency> currencies;

  final bool loading;
  final bool saving;

  StocksEditorPageData({
    required this.stock,
    required this.editStock,
    required this.shippingMethods,
    required this.countries,
    required this.currencies,
    required this.loading,
    required this.saving,
  });

  StocksEditorPageData copyWith({
    StockEntity? stock,
    StockEntityImpl? editStock,
    List<ShippingMethodEntity>? shippingMethods,
    bool? loading,
    List<StocksEditorPageDataCountry>? countries,
    List<StocksEditorPageDataCurrency>? currencies,
    bool? saving,
  }) {
    return StocksEditorPageData(
      stock: stock ?? this.stock,
      editStock: editStock ?? this.editStock,
      shippingMethods: shippingMethods ?? this.shippingMethods,
      countries: countries ?? this.countries,
      loading: loading ?? this.loading,
      currencies: currencies ?? this.currencies,
      saving: saving ?? this.saving,
    );
  }
}

class StocksEditorPageDataCountry {
  final String value;
  final String label;

  StocksEditorPageDataCountry({
    required this.value,
    required this.label,
  });
}

class StocksEditorPageDataCurrency {
  final String value;
  final String label;

  StocksEditorPageDataCurrency({
    required this.value,
    required this.label,
  });
}

class StocksEditorPageMethods {
  final void Function() goToShippingMethodsPage;
  final void Function(CountryEnum code) updateStockCountry;
  final void Function(String name) updateStockName;
  final void Function(String id) updateStockShippingMethod;
  final void Function(CurrencyEnum code) updateStockCurrency;
  final void Function() saveStock;

  final Future<void> Function() loadStock;
  final Future<void> Function() loadShippingMethods;
  final Future<void> Function() loadData;

  StocksEditorPageMethods({
    required this.goToShippingMethodsPage,
    required this.updateStockCountry,
    required this.updateStockName,
    required this.updateStockShippingMethod,
    required this.updateStockCurrency,
    required this.saveStock,
    required this.loadStock,
    required this.loadData,
    required this.loadShippingMethods,
  });
}

class StocksEditorPageController
    extends AppController<StocksEditorPageData, StocksEditorPageMethods> {
  final String stockId;
  late StocksEditorPageForm form;

  late final GetStockByIdUseCase _getStockByIdUseCase;
  late final GetAllShippingMethodsUseCase _getAllShippingMethodsUseCase;
  late final CreateStockUseCase _createStockUseCase;
  late final UpdateStockUseCase _updateStockUseCase;
  final LoadStocksEvent loadStocksEvent;

  StocksEditorPageController({
    required this.stockId,
    required final GetStockByIdUseCase getStockByIdUseCase,
    required final GetAllShippingMethodsUseCase getAllShippingMethodsUseCase,
    required final CreateStockUseCase createStockUseCase,
    required final UpdateStockUseCase updateStockUseCase,
    required this.loadStocksEvent,
  }) {
    _getStockByIdUseCase = getStockByIdUseCase;
    _getAllShippingMethodsUseCase = getAllShippingMethodsUseCase;
    _createStockUseCase = createStockUseCase;
    _updateStockUseCase = updateStockUseCase;
    methods.loadData();
  }

  @override
  StocksEditorPageMethods defineMethods() {
    return StocksEditorPageMethods(
      goToShippingMethodsPage: () {
        //TODO Create shippingMethods page.
      },
      updateStockCountry: (code) {
        updateData(
          data.copyWith(
            editStock: data.editStock.copyWith(
              country: code,
            ),
          ),
        );
      },
      updateStockCurrency: (code) {
        updateData(
          data.copyWith(
            editStock: data.editStock.copyWith(
              currency: code,
            ),
          ),
        );
      },
      updateStockName: (name) {
        updateData(
          data.copyWith(
            editStock: data.editStock.copyWith(
              name: name,
            ),
          ),
        );
      },
      updateStockShippingMethod: (id) {
        updateData(
          data.copyWith(
            editStock: data.editStock.copyWith(
              shippingMethod: id,
            ),
          ),
        );
      },
      saveStock: () async {
        updateData(
          data.copyWith(
            saving: true,
          ),
        );
        dispatchEvent(
          AppControllerEvent(
            id: 'savingStock',
            data: data,
          ),
        );
        try {
          if (stockId == 'null') {
            await _createStockUseCase(
              CreateStockDTO(
                name: data.editStock.name,
                country: countryEnumToString(data.editStock.country),
                currency: currencyEnumToString(data.editStock.currency),
                shippingMethod: data.editStock.shippingMethod,
              ),
            );
          } else {
            await _updateStockUseCase(
              UpdateStockDTO(
                id: data.editStock.id,
                name: data.editStock.name,
                country: countryEnumToString(data.editStock.country),
                currency: currencyEnumToString(data.editStock.currency),
                shippingMethod: data.editStock.shippingMethod,
              ),
            );
          }
          dispatchEvent(loadStocksEvent);
        } catch (e) {
          if (e is AppError) {
            catchError(e);
          }
        }
        updateData(
          data.copyWith(
            saving: false,
          ),
        );
      },
      loadShippingMethods: () async {
        final shippingMethods = await _getAllShippingMethodsUseCase(
          refresh: true,
        );
        updateData(
          data.copyWith(
            shippingMethods: shippingMethods,
          ),
        );
      },
      loadStock: () async {
        if (stockId != 'null') {
          final stock = await _getStockByIdUseCase(stockId);
          updateData(
            data.copyWith(
              stock: stock,
              editStock: StockEntityImpl(
                id: stock.id,
                name: stock.name,
                country: stock.country,
                currency: stock.currency,
                shippingMethod: stock.shippingMethod,
                createdAt: stock.createdAt,
              ),
            ),
          );
        }
      },
      loadData: () async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          await methods.loadShippingMethods();
          await methods.loadStock();
          form = StocksEditorPageForm(data.editStock);
        } catch (e) {
          if (e is AppError) {
            catchError(e);
          }
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
  StocksEditorPageData defineData() {
    return StocksEditorPageData(
      stock: StockEntityImpl(
        id: '',
        name: '',
        country: CountryEnum.br,
        currency: CurrencyEnum.brl,
        shippingMethod: '',
        createdAt: DateTime.now(),
      ),
      editStock: StockEntityImpl(
        id: '',
        name: '',
        country: CountryEnum.br,
        currency: CurrencyEnum.brl,
        shippingMethod: '',
        createdAt: DateTime.now(),
      ),
      shippingMethods: [],
      countries: [
        StocksEditorPageDataCountry(label: 'China', value: 'cn'),
        StocksEditorPageDataCountry(label: 'Brasil', value: 'br'),
      ],
      currencies: [
        StocksEditorPageDataCurrency(value: 'USD', label: 'Dólar'),
        StocksEditorPageDataCurrency(value: 'BRL', label: 'Real'),
      ],
      loading: true,
      saving: false,
    );
  }
}
