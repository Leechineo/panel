import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/core_module.dart';
import 'package:leechineo_panel/features/brand/data/usecases/create_brand_usecase_impl.dart';
import 'package:leechineo_panel/features/brand/data/usecases/get_all_brands_usecase_impl.dart';
import 'package:leechineo_panel/features/brand/data/usecases/get_brand_by_id_usecase_impl.dart';
import 'package:leechineo_panel/features/brand/data/usecases/update_brand_usecase_impl.dart';
import 'package:leechineo_panel/features/brand/presenter/controllers/brand_editor_page_controller/brand_editor_page_controller.dart';
import 'package:leechineo_panel/features/brand/presenter/controllers/brand_page_controller/brand_page_controller.dart';
import 'package:leechineo_panel/features/brand/presenter/events/load_brands_event.dart';
import 'package:leechineo_panel/features/brand/presenter/pages/brand_editor_page.dart';
import 'package:leechineo_panel/features/brand/presenter/pages/brand_page.dart';
import 'package:leechineo_panel/features/cloud_file/data/models/app_file_picker_extension_model.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/get_all_file_references_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/get_file_url_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/upload_file_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_main_page_controller.dart';

class BrandModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(LoadBrandsEvent.new);
    i.addLazySingleton<BrandPageController>(
      () => BrandPageController(
        i.get<GetAllBrandsUseCaseImpl>(),
        i.get<GetFileUrlUseCaseImpl>(),
        loadBrandsEvent: i.get<LoadBrandsEvent>(),
      ),
      config: BindConfig(
        onDispose: (value) => value.dispose(),
      ),
    );
    i.addSingleton<CloudFilesMainPageController<DarkIconPicker>>(
      () => CloudFilesMainPageController<DarkIconPicker>(
        multiple: false,
        uploadFileUseCase: i.get<UploadFileUseCaseImpl>(),
        getAllFileReferencesUseCase: i.get<GetAllFileReferencesUseCaseImpl>(),
        getFileUrlUseCase: i.get<GetFileUrlUseCaseImpl>(),
        allowedExtensions: [
          AppFilePickerExtension.svg,
        ],
      ),
      config: BindConfig(
        onDispose: (value) => value.dispose(),
      ),
    );
    i.addSingleton<CloudFilesMainPageController<LightIconPicker>>(
      () => CloudFilesMainPageController<LightIconPicker>(
        uploadFileUseCase: i.get<UploadFileUseCaseImpl>(),
        getAllFileReferencesUseCase: i.get<GetAllFileReferencesUseCaseImpl>(),
        getFileUrlUseCase: i.get<GetFileUrlUseCaseImpl>(),
        multiple: false,
        allowedExtensions: [
          AppFilePickerExtension.svg,
        ],
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
      child: (context) => BrandPage(
        brandsPageController: Modular.get<BrandPageController>(),
      ),
    );
    r.child(
      '/editor/:id/',
      child: (context) => BrandEditorPage(
        darkIconPickerController:
            Modular.get<CloudFilesMainPageController<DarkIconPicker>>(),
        lightIconPickerController:
            Modular.get<CloudFilesMainPageController<LightIconPicker>>(),
        controller: BrandEditorPageController(
          brandId: r.args.params['id'],
          createBrandUseCase: Modular.get<CreateBrandUseCaseImpl>(),
          getAllBrandsUseCase: Modular.get<GetAllBrandsUseCaseImpl>(),
          getBrandByIdUseCase: Modular.get<GetBrandByIdUseCaseImpl>(),
          getFileUrlUseCase: Modular.get<GetFileUrlUseCaseImpl>(),
          updateBrandUseCase: Modular.get<UpdateBrandUseCaseImpl>(),
          loadBrandsEvent: Modular.get<LoadBrandsEvent>(),
        ),
      ),
    );
  }
}
