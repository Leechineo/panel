import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/data/adapters/database_adapter_impl.dart';
import 'package:leechineo_panel/core/data/adapters/http_adapter_impl.dart';
import 'package:leechineo_panel/core/data/adapters/path_adapter_impl.dart';
import 'package:leechineo_panel/core/data/adapters/socket_adapter_impl.dart';
import 'package:leechineo_panel/features/address/data/datasources/address_datasource_impl.dart';
import 'package:leechineo_panel/features/address/data/repositories/address_repository_impl.dart';
import 'package:leechineo_panel/features/address/data/usecases/get_address_by_zipcode_usecase_impl.dart';
import 'package:leechineo_panel/features/address/data/usecases/get_user_adresses_usecase_impl.dart';
import 'package:leechineo_panel/features/auth/auth_module.dart';
import 'package:leechineo_panel/features/auth/data/datasources/auth_datasource_impl.dart';
import 'package:leechineo_panel/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:leechineo_panel/features/auth/data/usecases/get_authenticated_user_usecase_impl.dart';
import 'package:leechineo_panel/features/auth/data/usecases/login_usecase_impl.dart';
import 'package:leechineo_panel/features/auth/data/usecases/logout_usecase_impl.dart';
import 'package:leechineo_panel/features/brand/data/datasources/brand_datasource_impl.dart';
import 'package:leechineo_panel/features/brand/data/mappers/brand_color_mapper_impl.dart';
import 'package:leechineo_panel/features/brand/data/mappers/brand_dto_mapper_impl.dart';
import 'package:leechineo_panel/features/brand/data/mappers/brand_icon_mapper_impl.dart';
import 'package:leechineo_panel/features/brand/data/mappers/create_brand_dto_mapper_impl.dart';
import 'package:leechineo_panel/features/brand/data/mappers/update_brand_dto_mapper.dart';
import 'package:leechineo_panel/features/brand/data/repositories/brand_repository_impl.dart';
import 'package:leechineo_panel/features/brand/data/usecases/create_brand_usecase_impl.dart';
import 'package:leechineo_panel/features/brand/data/usecases/delete_brand_usecase_impl.dart';
import 'package:leechineo_panel/features/brand/data/usecases/get_all_brands_usecase_impl.dart';
import 'package:leechineo_panel/features/brand/data/usecases/get_brand_by_id_usecase_impl.dart';
import 'package:leechineo_panel/features/brand/data/usecases/update_brand_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/datasources/cloud_file_datasource_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/repositories/cloud_file_repository_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/get_all_file_references_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/get_file_url_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/upload_file_usecase_impl.dart';
import 'package:leechineo_panel/features/home/home_module.dart';
import 'package:leechineo_panel/features/home_section/domain/data/usecases/update_viewer_usecase_impl.dart';
import 'package:leechineo_panel/features/product/data/datasources/product_datasource_impl.dart';
import 'package:leechineo_panel/features/product/data/repositories/product_repository_impl.dart';
import 'package:leechineo_panel/features/product/data/usecases/get_products_usecase_impl.dart';
import 'package:leechineo_panel/features/setting/data/datasources/settings_datasource_impl.dart';
import 'package:leechineo_panel/features/setting/data/repositories/settings_repository_impl.dart';
import 'package:leechineo_panel/features/setting/data/usecases/get_payment_settings_usecase_impl.dart';
import 'package:leechineo_panel/features/setting/data/usecases/save_payment_settings_usecase_impl.dart';
import 'package:leechineo_panel/features/shipping_method/data/datasource/shipping_method_datasource_impl.dart';
import 'package:leechineo_panel/features/shipping_method/data/mappers/shipping_method_arrive_time_mapper_impl.dart';
import 'package:leechineo_panel/features/shipping_method/data/mappers/shipping_method_mapper_impl.dart';
import 'package:leechineo_panel/features/shipping_method/data/mappers/shipping_method_mapping_mapper_impl.dart';
import 'package:leechineo_panel/features/shipping_method/data/mappers/shipping_method_price_mapper_impl.dart';
import 'package:leechineo_panel/features/shipping_method/data/mappers/shipping_method_product_mapper_impl.dart';
import 'package:leechineo_panel/features/shipping_method/data/repositories/shipping_method_repository_impl.dart';
import 'package:leechineo_panel/features/shipping_method/data/usecases/calculate_shipping_usecase.dart';
import 'package:leechineo_panel/features/shipping_method/data/usecases/get_all_shipping_methods_usecase_impl.dart';
import 'package:leechineo_panel/features/splash/splash_module.dart';
import 'package:leechineo_panel/features/stock/data/datasources/stock_datasource_impl.dart';
import 'package:leechineo_panel/features/stock/data/mappers/create_stock_dto_mapper_impl.dart';
import 'package:leechineo_panel/features/stock/data/mappers/stock_dto_mapper_impl.dart';
import 'package:leechineo_panel/features/stock/data/mappers/update_stock_dto_mapper_impl.dart';
import 'package:leechineo_panel/features/stock/data/repositories/stock_repository_impl.dart';
import 'package:leechineo_panel/features/stock/data/usecases/create_stock_usecase_impl.dart';
import 'package:leechineo_panel/features/stock/data/usecases/get_all_stocks_usecase_impl.dart';
import 'package:leechineo_panel/features/stock/data/usecases/get_stock_by_id_impl.dart';
import 'package:leechineo_panel/features/stock/data/usecases/update_stock_usecase_impl.dart';
import 'package:leechineo_panel/features/user/data/datasources/user_datasource_impl.dart';
import 'package:leechineo_panel/features/user/data/mappers/create_user_dto_mapper.dart';
import 'package:leechineo_panel/features/user/data/mappers/update_user_dto_mapper_impl.dart';
import 'package:leechineo_panel/features/user/data/repositories/user_repository_impl.dart';
import 'package:leechineo_panel/features/user/data/usecases/create_user_usecase_impl.dart';
import 'package:leechineo_panel/features/user/data/usecases/get_user_usecase_impl.dart';
import 'package:leechineo_panel/features/user/data/usecases/get_users_usecase_impl.dart';
import 'package:leechineo_panel/features/user/data/usecases/update_user_usecase_impl.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton(
      DatabaseAdapterImpl.new,
    );
    i.addSingleton(
      () => HttpAdapterImpl(
        i.get<DatabaseAdapterImpl>(),
      ),
    );
    i.addLazySingleton(
      () => SocketAdapterImpl(
        serverUrl: 'http://localhost:7151/',
      ),
    );
    i.addLazySingleton(
      PathAdapterImpl.new,
    );

    // Auth dependencies
    i.addSingleton(
      () => AuthDatasourceImpl(
        httpAdapter: i.get<HttpAdapterImpl>(),
        databaseAdapter: i.get<DatabaseAdapterImpl>(),
      ),
    );
    i.addSingleton(
      () => AuthRepositoryImpl(
        i.get<AuthDatasourceImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetAuthenticatedUserUseCaseImpl(
        i.get<AuthRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => LoginUseCaseImpl(
        i.get<AuthRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => LogoutUseCaseImpl(
        i.get<AuthRepositoryImpl>(),
      ),
    );

    // Cloud File dependencies
    i.addLazySingleton(
      () => CloudFileDatasourceImpl(
        i.get<HttpAdapterImpl>(),
      ),
    );
    i.addLazySingleton(
      () => CloudFileRepositoryImpl(
        i.get<CloudFileDatasourceImpl>(),
      ),
    );
    i.addLazySingleton(
      () => UploadFileUseCaseImpl(
        i.get<CloudFileRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetAllFileReferencesUseCaseImpl(
        i.get<CloudFileRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetFileUrlUseCaseImpl(
        i.get<HttpAdapterImpl>(),
      ),
    );

    // Shipping Method dependencies
    i.addLazySingleton(
      () => ShippingMethodPriceMapperImpl(),
    );
    i.addLazySingleton(
      () => ShippingMethodArriveTimeMapperImpl(),
    );
    i.addLazySingleton(
      () => ShippingMethodMappingMapperImpl(
        i.get<ShippingMethodArriveTimeMapperImpl>(),
        i.get<ShippingMethodPriceMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => ShippingMethodProductMapperImpl(
        i.get<ShippingMethodMappingMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => ShippingMethodMapperImpl(
        i.get<ShippingMethodMappingMapperImpl>(),
        i.get<ShippingMethodProductMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => ShippingMethodDatasourceImpl(
        i.get<HttpAdapterImpl>(),
        i.get<ShippingMethodMapperImpl>(),
        i.get<ShippingMethodMappingMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => ShippingMethodRepositoryImpl(
        i.get<ShippingMethodDatasourceImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetAllShippingMethodsUseCaseImpl(
        i.get<ShippingMethodRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => CalculateShippingUseCaseImpl(
        shippingMethodRepository: i.get<ShippingMethodRepositoryImpl>(),
      ),
    );

    // Stock dependencies
    i.addLazySingleton(
      () => CreateStockDTOMapperImpl(),
    );
    i.addLazySingleton(
      () => UpdateStockDTOMapperImpl(),
    );
    i.addLazySingleton(
      () => StockDTOMapperImpl(),
    );
    i.addLazySingleton(
      () => StockDatasourceImpl(
        i.get<HttpAdapterImpl>(),
        i.get<StockDTOMapperImpl>(),
        i.get<CreateStockDTOMapperImpl>(),
        i.get<UpdateStockDTOMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => StockRepositoryImpl(
        i.get<StockDatasourceImpl>(),
        i.get<StockDTOMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetAllStocksUseCaseImpl(
        i.get<StockRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => CreateStockUseCaseImpl(
        i.get<StockRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => UpdateStockUseCaseImpl(
        i.get<StockRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetStockByIdUseCaseImpl(
        i.get<StockRepositoryImpl>(),
      ),
    );

    // Brand dependencies
    i.addLazySingleton(
      () => BrandIconMapperImpl(),
    );
    i.addLazySingleton(
      () => BrandColorMapperImpl(),
    );
    i.addLazySingleton(
      () => CreateBrandDTOMapperImpl(
        i.get<BrandIconMapperImpl>(),
        i.get<BrandColorMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => UpdateBrandDTOMapperImpl(
        i.get<BrandIconMapperImpl>(),
        i.get<BrandColorMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => BrandDTOMapperImpl(
        i.get<BrandIconMapperImpl>(),
        i.get<BrandColorMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => BrandDatasourceImpl(
        httpAdapter: i.get<HttpAdapterImpl>(),
        brandDTOMapper: i.get<BrandDTOMapperImpl>(),
        createBrandDTOMapper: i.get<CreateBrandDTOMapperImpl>(),
        updateBrandDTOMapper: i.get<UpdateBrandDTOMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => BrandRepositoryImpl(
        i.get<BrandDatasourceImpl>(),
        i.get<BrandDTOMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => CreateBrandUseCaseImpl(
        i.get<BrandRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetAllBrandsUseCaseImpl(
        i.get<BrandRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetBrandByIdUseCaseImpl(
        i.get<BrandRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => UpdateBrandUseCaseImpl(
        i.get<BrandRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => DeleteBrandUseCaseImpl(
        i.get<BrandRepositoryImpl>(),
      ),
    );

    // User dependencies
    i.addLazySingleton(
      () => CreateUserDTOMapperImpl(),
    );
    i.addLazySingleton(
      () => UpdateUserDTOMapperImpl(),
    );
    i.addLazySingleton(
      () => UserDatasourceImpl(
        httpAdapter: i.get<HttpAdapterImpl>(),
        createUserDTOMapper: i.get<CreateUserDTOMapperImpl>(),
        updateUserDTOMapper: i.get<UpdateUserDTOMapperImpl>(),
      ),
    );
    i.addLazySingleton(
      () => UserRepositoryImpl(
        i.get<UserDatasourceImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetUsersUseCaseImpl(
        i.get<UserRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetUserUseCaseImpl(
        i.get<UserRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => CreateUserUseCaseImpl(
        i.get<UserRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => UpdateUserUseCaseImpl(
        i.get<UserRepositoryImpl>(),
      ),
    );

    // Product dependencies
    i.addLazySingleton(
      () => ProductDatasouceImpl(
        httpAdapter: i.get<HttpAdapterImpl>(),
      ),
    );
    i.addLazySingleton(
      () => ProductRepositoryImpl(
        productDatasource: i.get<ProductDatasouceImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetProductsUseCaseImpl(
        productRepository: i.get<ProductRepositoryImpl>(),
      ),
    );

    // Address dependencies
    i.addLazySingleton(
      () => AddressDatasourceImpl(
        httpAdapter: i.get<HttpAdapterImpl>(),
      ),
    );
    i.addLazySingleton(
      () => AddressRepositoryImpl(
        addressDatasource: i.get<AddressDatasourceImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetAddressByZipcodeUseCaseImpl(
        addressRepository: i.get<AddressRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetUserAddressesUseCaseImpl(
        addressRepository: i.get<AddressRepositoryImpl>(),
      ),
    );

    //Settings Dependencies
    i.addLazySingleton(
      () => SettingsDatasourceImpl(
        httpAdapter: i.get<HttpAdapterImpl>(),
      ),
    );
    i.addLazySingleton(
      () => SettingsRepositoryImpl(
        settingsDatasource: i.get<SettingsDatasourceImpl>(),
      ),
    );
    i.addLazySingleton(
      () => GetPaymentSettingsUseCaseImpl(
        settingsRepository: i.get<SettingsRepositoryImpl>(),
      ),
    );
    i.addLazySingleton(
      () => SavePaymentSettingsUseCaseImpl(
        settingsRepository: i.get<SettingsRepositoryImpl>(),
      ),
    );

    //Sections Dependencies
    i.addLazySingleton(
      () => UpdateViewerUsecaseImpl(
        pathAdapter: i.get<PathAdapterImpl>(),
        socketAdater: i.get<SocketAdapterImpl>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: SplashModule());
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
  }
}
