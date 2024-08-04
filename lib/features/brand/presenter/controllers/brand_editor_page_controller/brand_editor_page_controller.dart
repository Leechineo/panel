import 'dart:ui';

import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/brand/data/entities/brand_entity_impl.dart';
import 'package:leechineo_panel/features/brand/domain/dtos/create_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/dtos/update_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/domain/usecases/create_brand_usecase.dart';
import 'package:leechineo_panel/features/brand/domain/usecases/get_all_brands_usecase.dart';
import 'package:leechineo_panel/features/brand/domain/usecases/get_brand_by_id_usecase.dart';
import 'package:leechineo_panel/features/brand/domain/usecases/update_brand_usecase.dart';
import 'package:leechineo_panel/features/brand/presenter/controllers/brand_editor_page_controller/brand_editor_page_data.dart';
import 'package:leechineo_panel/features/brand/presenter/controllers/brand_editor_page_controller/brand_editor_page_form.dart';
import 'package:leechineo_panel/features/brand/presenter/controllers/brand_editor_page_controller/brand_editor_page_methods.dart';
import 'package:leechineo_panel/features/brand/presenter/events/load_brands_event.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';

class BrandEditorPageController
    extends AppController<BrandEditorPageData, BrandEditorPageMethods> {
  /// The ID of the brand to be edited.
  final String brandId;
  final CreateBrandUseCase createBrandUseCase;
  final UpdateBrandUseCase updateBrandUseCase;
  final GetAllBrandsUseCase getAllBrandsUseCase;
  final GetBrandByIdUseCase getBrandByIdUseCase;
  final GetFileUrlUseCase getFileUrlUseCase;
  final LoadBrandsEvent loadBrandsEvent;

  // Form instance for the Brands Editor page and controller.
  late BrandEditorPageForm form;

  BrandEditorPageController({
    required this.brandId,
    required this.createBrandUseCase,
    required this.updateBrandUseCase,
    required this.getAllBrandsUseCase,
    required this.getBrandByIdUseCase,
    required this.getFileUrlUseCase,
    required this.loadBrandsEvent,
  }) {
    methods.loadBrand();
  }

  // Sets the [methods] that will be used by this controller and the page.
  @override
  BrandEditorPageMethods defineMethods() {
    return BrandEditorPageMethods(
      // Method to update [editBrand] with the provided [brand].
      updateEditBrand: (brand) {
        updateData(
          data.copyWith(
            editBrand: brand,
          ),
        );
      },

      // Method to toggle color picker expansion state.
      toggleColorPickerExpansion: () {
        updateData(
          data.copyWith(
            colorPickerExpanded: !data.colorPickerExpanded,
          ),
        );
      },

      // Method to update brand name in [editBrand].
      updateBrandName: (String name) => methods.updateEditBrand(
        data.editBrand.copyWith(
          name: name,
        ),
      ),

      // Method to update brand website in [editBrand].
      updateBrandWebsite: (brandWebsite) => methods.updateEditBrand(
        data.editBrand.copyWith(
          brandWebsite: brandWebsite,
        ),
      ),

      // Method to update brand icon in [editBrand].
      updateBrandIcon: (iconId, dark) {
        if (dark) {
          methods.updateEditBrand(
            data.editBrand.copyWith(
              icon: data.editBrand.icon.copyWith(
                dark: iconId,
              ),
            ),
          );
        } else {
          methods.updateEditBrand(
            data.editBrand.copyWith(
              icon: data.editBrand.icon.copyWith(
                light: iconId,
              ),
            ),
          );
        }
      },

      // Method to update brand icon background color in [editBrand].
      updateBrandIconBackground: (color, dark) {
        if (dark) {
          methods.updateEditBrand(
            data.editBrand.copyWith(
              color: data.editBrand.color.copyWith(
                dark: color,
              ),
            ),
          );
        } else {
          methods.updateEditBrand(
            data.editBrand.copyWith(
              color: data.editBrand.color.copyWith(
                light: color,
              ),
            ),
          );
        }
      },

      // Method to set brand icon in [editBrand].
      setBrandIcon: (iconId, dark) {
        if (dark) {
          methods.updateEditBrand(
            data.editBrand.copyWith(
              icon: data.editBrand.icon.copyWith(
                dark: iconId,
              ),
            ),
          );
        } else {
          methods.updateEditBrand(
            data.editBrand.copyWith(
              icon: data.editBrand.icon.copyWith(
                light: iconId,
              ),
            ),
          );
        }
      },

      // Method to save the modified brand.
      saveBrand: () async {
        updateData(
          data.copyWith(
            saving: true,
          ),
        );
        dispatchEvent(
          AppControllerEvent(
            id: 'savingBrand',
            data: data,
          ),
        );
        try {
          if (brandId == 'null') {
            await createBrandUseCase(
              CreateBrandDTO(
                name: data.editBrand.name,
                color: data.editBrand.color,
                icon: data.editBrand.icon,
                brandWebsite: data.editBrand.brandWebsite,
              ),
            );
          } else {
            await updateBrandUseCase(
              UpdateBrandDTO(
                id: data.editBrand.id,
                name: data.editBrand.name,
                color: data.editBrand.color,
                icon: data.editBrand.icon,
                brandWebsite: data.editBrand.brandWebsite,
              ),
            );
          }
          dispatchEvent(loadBrandsEvent);
        } catch (e) {
          catchError(e);
        }
        updateData(
          data.copyWith(
            saving: false,
          ),
        );
      },
      loadBrand: () async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          if (brandId != 'null') {
            final brand = await getBrandByIdUseCase(brandId);
            updateData(
              data.copyWith(
                brand: brand,
                editBrand: BrandEntityImpl(
                  id: brand.id,
                  name: brand.name,
                  icon: brand.icon,
                  color: brand.color,
                  brandWebsite: brand.brandWebsite,
                  createdAt: brand.createdAt,
                ),
              ),
            );
          }
          form = BrandEditorPageForm(data.editBrand);
        } catch (e) {
          catchError(e);
        }
        updateData(
          data.copyWith(
            loading: false,
          ),
        );
      },
      getUrl: (fileId) {
        final url = getFileUrlUseCase(fileId);
        return url;
      },
      restoreDefault: (brand) {
        updateData(
          data.copyWith(
            editBrand: BrandEntityImpl(
              id: brand.id,
              name: brand.name,
              icon: brand.icon,
              color: brand.color,
              brandWebsite: brand.brandWebsite,
              createdAt: brand.createdAt,
            ),
          ),
        );
      },
    );
  }

  // Sets the data that will be used by this controller and the page.
  @override
  BrandEditorPageData defineData() {
    return BrandEditorPageData(
      brand: BrandEntityImpl(
        id: '',
        name: '',
        icon: BrandIcon(light: '', dark: ''),
        color: BrandColor(
          light: const Color(0xffF5F5F5),
          dark: const Color(0xff1E1E1E),
        ),
        brandWebsite: '',
        createdAt: DateTime.now(),
      ),
      editBrand: BrandEntityImpl(
        id: '',
        name: '',
        icon: BrandIcon(light: '', dark: ''),
        color: BrandColor(
          light: const Color(0xffF5F5F5),
          dark: const Color(0xff1E1E1E),
        ),
        brandWebsite: '',
        createdAt: DateTime.now(),
      ),
      colorPickerExpanded: false,
      saving: false,
      loading: true,
    );
  }
}
