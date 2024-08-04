import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/core_module.dart';
import 'package:leechineo_panel/features/setting/data/usecases/get_payment_settings_usecase_impl.dart';
import 'package:leechineo_panel/features/setting/data/usecases/save_payment_settings_usecase_impl.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/installment_settings_controller/Installment_settings_controller.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/payment_methods_controller.dart/payment_methods_controller.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/payment_settings_page_controller/payment_settings_page_controller.dart';
import 'package:leechineo_panel/features/setting/presenter/pages/setting_page.dart';

class SettingModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];
  @override
  void binds(Injector i) {
    i.addLazySingleton(
      () => InstallmentSettingsController(),
    );
    i.addLazySingleton(
      () => PaymentMethodsControler(),
    );
    i.addLazySingleton(
      () => PaymentSettingsPageController(
        getPaymentSettingsUseCase: i.get<GetPaymentSettingsUseCaseImpl>(),
        savePaymentSettingsUseCase: i.get<SavePaymentSettingsUseCaseImpl>(),
        installmentSettingsController: i.get<InstallmentSettingsController>(),
        paymentMethodsControler: i.get<PaymentMethodsControler>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => SettingPage(
        paymentSettingsPageController:
            Modular.get<PaymentSettingsPageController>(),
      ),
    );
  }
}
