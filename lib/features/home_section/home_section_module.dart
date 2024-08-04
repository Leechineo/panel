import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/core_module.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/get_all_file_references_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/get_file_url_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/upload_file_usecase_impl.dart';
import 'package:leechineo_panel/features/home_section/domain/data/usecases/update_viewer_usecase_impl.dart';
import 'package:leechineo_panel/features/home_section/presenter/controllers/home_section_controller/home_section_controller.dart';
import 'package:leechineo_panel/features/home_section/presenter/pages/home_section_page.dart';

class HomeSectionModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];
  @override
  void binds(Injector i) {
    i.addLazySingleton<HomeSectionController>(
      () => HomeSectionController(
        updateViewerUseCase: i.get<UpdateViewerUsecaseImpl>(),
      ),
      config: BindConfig(
        onDispose: (value) => value.dispose(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => HomeSectionPage(
        controller: Modular.get<HomeSectionController>(),
        getAllFileReferencesUseCase:
            Modular.get<GetAllFileReferencesUseCaseImpl>(),
        getFileUrlUseCase: Modular.get<GetFileUrlUseCaseImpl>(),
        uploadFileUseCase: Modular.get<UploadFileUseCaseImpl>(),
      ),
    );
  }
}
