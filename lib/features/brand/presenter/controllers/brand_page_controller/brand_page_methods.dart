class BrandPageMethods {
  final void Function(String id) goToBrandsEditorPage;
  final String Function(String fileId) getFileUrl;
  final Future<void> Function() loadBrands;

  BrandPageMethods({
    required this.goToBrandsEditorPage,
    required this.getFileUrl,
    required this.loadBrands,
  });
}
