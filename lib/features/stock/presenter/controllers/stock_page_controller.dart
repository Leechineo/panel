import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/domain/enums/country_enum.dart';
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/core/domain/errors/app_error.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/usecases/get_all_shipping_methods_usecase.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/get_all_stocks_usecase.dart';
import 'package:leechineo_panel/features/stock/presenter/events/load_stocks_event.dart';

class StocksPageData {
  final List<StockEntity> stocks;
  final List<ShippingMethodEntity> shippingMethods;

  final bool loading;

  StocksPageData({
    required this.stocks,
    required this.shippingMethods,
    required this.loading,
  });

  StocksPageData copyWith({
    List<StockEntity>? stocks,
    List<ShippingMethodEntity>? shippingMethods,
    bool? loading,
  }) {
    return StocksPageData(
      stocks: stocks ?? this.stocks,
      shippingMethods: shippingMethods ?? this.shippingMethods,
      loading: loading ?? this.loading,
    );
  }
}

class StocksPageMethods {
  final String Function(CountryEnum code) getCountryNameByCode;
  final String Function(String id) getShippingMethodNameById;
  final String Function(CurrencyEnum code) getCurrencyNameByCode;
  final void Function(String id) goToEditorPage;

  final Future<void> Function() loadShippingMethods;
  final Future<void> Function() loadStocks;

  final Future<void> Function() loadData;

  StocksPageMethods({
    required this.getCountryNameByCode,
    required this.getShippingMethodNameById,
    required this.getCurrencyNameByCode,
    required this.goToEditorPage,
    required this.loadShippingMethods,
    required this.loadStocks,
    required this.loadData,
  });
}

class StocksPageController
    extends AppController<StocksPageData, StocksPageMethods> {
  late final GetAllStocksUseCase _getAllStocksUseCase;
  late final GetAllShippingMethodsUseCase _getAllShippingMethodsUseCase;
  final LoadStocksEvent loadStocksEvent;
  StocksPageController({
    required final GetAllStocksUseCase getAllStocksUseCase,
    required final GetAllShippingMethodsUseCase getAllShippingMethodsUseCase,
    required this.loadStocksEvent,
  }) : super(events: [loadStocksEvent]) {
    _getAllShippingMethodsUseCase = getAllShippingMethodsUseCase;
    _getAllStocksUseCase = getAllStocksUseCase;
    dispatchEvent(loadStocksEvent);
  }

  @override
  void onEventDispatched(AppControllerEvent event) {
    if (event is LoadStocksEvent) {
      methods.loadData();
    }
  }

  @override
  StocksPageMethods defineMethods() {
    return StocksPageMethods(
      getCountryNameByCode: (code) {
        switch (code) {
          case CountryEnum.cn:
            return 'China';
          default:
            return 'Brasil';
        }
      },
      getShippingMethodNameById: (id) {
        if (data.shippingMethods
            .where((element) => element.id == id)
            .isNotEmpty) {
          final ShippingMethodEntity shippingMethod =
              data.shippingMethods.firstWhere(
            (element) => element.id == id,
          );
          return shippingMethod.name;
        }
        return '';
      },
      getCurrencyNameByCode: (code) {
        switch (code) {
          case CurrencyEnum.usd:
            return 'Dólar';
          default:
            return 'Real';
        }
      },
      goToEditorPage: (id) {
        Modular.to.pushNamed('/home/stock/editor/$id/');
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
      loadStocks: () async {
        final stocks = await _getAllStocksUseCase(
          refresh: true,
        );
        updateData(
          data.copyWith(
            stocks: stocks,
          ),
        );
      },
      loadData: () async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          await methods.loadShippingMethods();
          await methods.loadStocks();
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
  StocksPageData defineData() {
    return StocksPageData(
      stocks: [],
      shippingMethods: [],
      loading: true,
    );
  }
}
