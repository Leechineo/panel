import 'package:leechineo_panel/features/brand/data/entities/brand_entity_impl.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

/// Data class that holds the various state and information related to the Brands Editor page.
class BrandEditorPageData {
  /// The original [Brand] instance representing the brand being edited.
  final BrandEntity brand;

  /// The editable copy of the [BrandEntity] instance for modification.
  final BrandEntityImpl editBrand;

  /// Flag indicating whether the color picker is expanded or collapsed.
  final bool colorPickerExpanded;

  /// Flag indicating whether the brand is currently being saved.
  final bool saving;

  final bool loading;

  /// Creates a new instance of [BrandEditorPageData] with the given parameters.
  BrandEditorPageData({
    required this.brand,
    required this.editBrand,
    required this.colorPickerExpanded,
    required this.saving,
    required this.loading,
  });

  /// Creates a new instance of [BrandEditorPageData] by copying the existing instance and optionally updating its fields.
  BrandEditorPageData copyWith({
    BrandEntity? brand,
    BrandEntityImpl? editBrand,
    bool? colorPickerExpanded,
    bool? saving,
    bool? loading,
  }) {
    return BrandEditorPageData(
      brand: brand ?? this.brand,
      editBrand: editBrand ?? this.editBrand,
      colorPickerExpanded: colorPickerExpanded ?? this.colorPickerExpanded,
      saving: saving ?? this.saving,
      loading: loading ?? this.loading,
    );
  }
}
