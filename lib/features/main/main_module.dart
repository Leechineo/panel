import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/get_all_file_references_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/get_file_url_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/upload_file_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_main_page_controller.dart';
import 'package:leechineo_panel/features/main/presenter/pages/main_page.dart';

class MainModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(
      () => CloudFilesMainPageController<MainModule>(
        uploadFileUseCase: i.get<UploadFileUseCaseImpl>(),
        getAllFileReferencesUseCase: i.get<GetAllFileReferencesUseCaseImpl>(),
        getFileUrlUseCase: i.get<GetFileUrlUseCaseImpl>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => MainPage(
        cloudFilesMainPageController:
            Modular.get<CloudFilesMainPageController<MainModule>>(),
      ),
    );
  }
}
