import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/core_module.dart';
import 'package:leechineo_panel/features/admin/admin_module.dart';
import 'package:leechineo_panel/features/auth/data/usecases/get_authenticated_user_usecase_impl.dart';
import 'package:leechineo_panel/features/auth/data/usecases/logout_usecase_impl.dart';
import 'package:leechineo_panel/features/brand/brand_module.dart';
import 'package:leechineo_panel/features/category/category_module.dart';
import 'package:leechineo_panel/features/cloud_file/cloud_file_module.dart';
import 'package:leechineo_panel/features/financial/financial_module.dart';
import 'package:leechineo_panel/features/home/presenter/controllers/home_page_controller.dart';
import 'package:leechineo_panel/features/home/presenter/pages/home_page.dart';
import 'package:leechineo_panel/features/home_section/home_section_module.dart';
import 'package:leechineo_panel/features/log/log_module.dart';
import 'package:leechineo_panel/features/main/main_module.dart';
import 'package:leechineo_panel/features/order/order_module.dart';
import 'package:leechineo_panel/features/product/product_module.dart';
import 'package:leechineo_panel/features/promotion/promotion_module.dart';
import 'package:leechineo_panel/features/setting/setting_module.dart';
import 'package:leechineo_panel/features/shipping_method/shipping_method_module.dart';
import 'package:leechineo_panel/features/stock/stock_module.dart';
import 'package:leechineo_panel/features/user/user_module.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<HomePageController>(
      () => HomePageController(
          i.get<LogoutUseCaseImpl>(), i.get<GetAuthenticatedUserUseCaseImpl>()),
      config: BindConfig(
        onDispose: (value) => value.dispose(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => HomePage(
        controller: Modular.get<HomePageController>(),
      ),
      children: [
        ModuleRoute(
          '/main/',
          module: MainModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/cloud_file/',
          module: CloudFileModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/stock/',
          module: StockModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/product/',
          module: ProductModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/home_section/',
          module: HomeSectionModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/category/',
          module: CategoryModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/brand/',
          module: BrandModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/promotion/',
          module: PromotionModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/shipping_method/',
          module: ShippingMethodModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/user/',
          module: UserModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/order/',
          module: OrderModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/financial_module/',
          module: FinancialModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/admin/',
          module: AdminModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/setting/',
          module: SettingModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          '/log/',
          module: LogModule(),
          transition: TransitionType.noTransition,
        ),
      ],
    );
  }
}
