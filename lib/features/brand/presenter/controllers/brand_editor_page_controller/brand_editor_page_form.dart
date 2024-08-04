import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

/// A form class that encapsulates the form fields and data for the Brands Editor page.
class BrandEditorPageForm {
  /// The [Brand] instance associated with this form.
  final BrandEntity brand;

  /// The key to uniquely identify and manage the state of the form.
  late final GlobalKey<FormState> formKey;

  /// Controller for managing the input field value for the brand's name.
  late final TextEditingController nameController;

  /// Controller for managing the input field value for the brand's website.
  late final TextEditingController websiteController;

  /// Creates a new instance of [BrandEditorPageForm] and initializes its properties.
  BrandEditorPageForm(this.brand) {
    // Initialize form key for managing the form state.
    formKey = GlobalKey<FormState>();

    // Initialize controllers for name and website input fields.
    nameController = TextEditingController();
    websiteController = TextEditingController();

    // Set initial values in the controllers based on the provided [brand].
    nameController.text = brand.name;
    websiteController.text = brand.brandWebsite;
  }
}
