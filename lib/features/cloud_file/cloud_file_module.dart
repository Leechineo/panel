import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/get_all_file_references_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/get_file_url_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/upload_file_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_main_page_controller.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/pages/cloud_files_main_page.dart';

class CloudFileModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<CloudFilesMainPageController<CloudFileModule>>(
      () => CloudFilesMainPageController<CloudFileModule>(
        uploadFileUseCase: i.get<UploadFileUseCaseImpl>(),
        getAllFileReferencesUseCase: i.get<GetAllFileReferencesUseCaseImpl>(),
        getFileUrlUseCase: i.get<GetFileUrlUseCaseImpl>(),
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
      child: (context) => CloudFilesMainPage(
        controller:
            Modular.get<CloudFilesMainPageController<CloudFileModule>>(),
      ),
    );
  }
}
