import 'package:flutter/widgets.dart';
import 'package:leechineo_panel/features/brand/data/entities/brand_entity_impl.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

/// A class that encapsulates various methods for interacting with the Brands Editor page.
class BrandEditorPageMethods {
  /// Callback to toggle the expansion state of the color picker.
  final void Function() toggleColorPickerExpansion;

  /// Callback to update the editable brand data being modified.
  final void Function(BrandEntityImpl brand) updateEditBrand;

  /// Callback to update the name of the brand being edited.
  final void Function(String name) updateBrandName;

  /// Callback to update the website of the brand being edited.
  final void Function(String brandWebsite) updateBrandWebsite;

  /// Callback to update the icon of the brand being edited.
  final void Function(String iconId, bool dark) updateBrandIcon;

  /// Callback to update the icon background color of the brand being edited.
  final void Function(Color color, bool dark) updateBrandIconBackground;

  /// Callback to set the icon of the brand being edited.
  final void Function(String iconId, bool dark) setBrandIcon;

  /// Callback to initiate the saving process for the modified brand.
  final Future<void> Function() saveBrand;

  final Future<void> Function() loadBrand;
  final String Function(String fileId) getUrl;
  final void Function(BrandEntity brand) restoreDefault;

  /// Creates a new instance of [BrandEditorPageMethods] with the provided callbacks.
  BrandEditorPageMethods({
    required this.toggleColorPickerExpansion,
    required this.updateEditBrand,
    required this.updateBrandName,
    required this.updateBrandWebsite,
    required this.updateBrandIcon,
    required this.updateBrandIconBackground,
    required this.setBrandIcon,
    required this.saveBrand,
    required this.loadBrand,
    required this.getUrl,
    required this.restoreDefault,
  });
}
