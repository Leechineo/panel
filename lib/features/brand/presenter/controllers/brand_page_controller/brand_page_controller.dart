import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/brand/domain/usecases/get_all_brands_usecase.dart';
import 'package:leechineo_panel/features/brand/presenter/controllers/brand_page_controller/brand_page_data.dart';
import 'package:leechineo_panel/features/brand/presenter/controllers/brand_page_controller/brand_page_methods.dart';
import 'package:leechineo_panel/features/brand/presenter/events/load_brands_event.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';

class BrandPageController
    extends AppController<BrandPageData, BrandPageMethods> {
  final GetAllBrandsUseCase getAllBrandsUseCase;
  final GetFileUrlUseCase getFileUrlUseCase;
  final LoadBrandsEvent loadBrandsEvent;

  BrandPageController(
    this.getAllBrandsUseCase,
    this.getFileUrlUseCase, {
    required this.loadBrandsEvent,
  }) : super(events: [loadBrandsEvent]) {
    dispatchEvent(loadBrandsEvent);
  }

  @override
  void onEventDispatched(AppControllerEvent event) {
    if (event is LoadBrandsEvent) {
      methods.loadBrands();
    }
  }

  @override
  BrandPageMethods defineMethods() {
    return BrandPageMethods(
      goToBrandsEditorPage: (id) => Modular.to.pushNamed(
        '/home/brand/editor/$id/',
      ),
      getFileUrl: (fileId) {
        final url = getFileUrlUseCase(fileId);
        return url;
      },
      loadBrands: () async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          final brands = await getAllBrandsUseCase();
          updateData(
            data.copyWith(
              brands: brands,
            ),
          );
        } catch (e) {
          catchError(e);
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
  BrandPageData defineData() {
    return BrandPageData(
      brands: [],
      loading: true,
    );
  }
}
