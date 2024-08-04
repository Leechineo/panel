import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/core_module.dart';
import 'package:leechineo_panel/features/shipping_method/data/usecases/get_all_shipping_methods_usecase_impl.dart';
import 'package:leechineo_panel/features/stock/data/usecases/create_stock_usecase_impl.dart';
import 'package:leechineo_panel/features/stock/data/usecases/get_all_stocks_usecase_impl.dart';
import 'package:leechineo_panel/features/stock/data/usecases/get_stock_by_id_impl.dart';
import 'package:leechineo_panel/features/stock/data/usecases/update_stock_usecase_impl.dart';
import 'package:leechineo_panel/features/stock/presenter/controllers/stock_editor_page_controller.dart';
import 'package:leechineo_panel/features/stock/presenter/controllers/stock_page_controller.dart';
import 'package:leechineo_panel/features/stock/presenter/events/load_stocks_event.dart';
import 'package:leechineo_panel/features/stock/presenter/pages/stock_page.dart';
import 'package:leechineo_panel/features/stock/presenter/pages/stocks_editor_page.dart';

class StockModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(LoadStocksEvent.new);
    i.addLazySingleton<StocksPageController>(
      () => StocksPageController(
        getAllStocksUseCase: i.get<GetAllStocksUseCaseImpl>(),
        getAllShippingMethodsUseCase: i.get<GetAllShippingMethodsUseCaseImpl>(),
        loadStocksEvent: i.get<LoadStocksEvent>(),
      ),
      config: BindConfig(
        onDispose: (value) => value.dispose(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => StocksPage(
        controller: Modular.get<StocksPageController>(),
      ),
    );
    r.child(
      '/editor/:id/',
      child: (context) => StocksEditorPage(
        controller: StocksEditorPageController(
          stockId: r.args.params['id'],
          createStockUseCase: Modular.get<CreateStockUseCaseImpl>(),
          updateStockUseCase: Modular.get<UpdateStockUseCaseImpl>(),
          getStockByIdUseCase: Modular.get<GetStockByIdUseCaseImpl>(),
          getAllShippingMethodsUseCase:
              Modular.get<GetAllShippingMethodsUseCaseImpl>(),
          loadStocksEvent: Modular.get<LoadStocksEvent>(),
        ),
      ),
    );
  }
}
