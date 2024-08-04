import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/utils/display_helper.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/features/brand/presenter/controllers/brand_editor_page_controller/brand_editor_page_controller.dart';
import 'package:leechineo_panel/features/brand/presenter/widgets/brand_color_picker.dart';
import 'package:leechineo_panel/features/brand/presenter/widgets/brand_icon_picker.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_main_page_controller.dart';

class BrandEditorPage extends StatefulWidget {
  final BrandEditorPageController controller;
  final CloudFilesMainPageController<DarkIconPicker> darkIconPickerController;
  final CloudFilesMainPageController<LightIconPicker> lightIconPickerController;
  const BrandEditorPage({
    required this.controller,
    required this.darkIconPickerController,
    required this.lightIconPickerController,
    super.key,
  });

  @override
  State<BrandEditorPage> createState() => _BrandsEditorPageState();
}

class _BrandsEditorPageState extends State<BrandEditorPage> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 12, 12),
      child: Scaffold(
        body: widget.controller.builder(
          builder: (context, data) {
            if (data.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
              key: widget.controller.form.formKey,
              child: AppCard(
                flexible: true,
                contentPadding: const EdgeInsets.all(12),
                actions: [
                  FilledButton(
                    onPressed:
                        data.editBrand.toString() == data.brand.toString()
                            ? null
                            : () {
                                widget.controller.methods
                                    .restoreDefault(data.brand);
                                widget.controller.form.nameController.text =
                                    data.brand.name;
                                widget.controller.form.websiteController.text =
                                    data.brand.brandWebsite;
                              },
                    child: const Text('Desfazer alterações'),
                  ),
                  const AppDivider(
                    vertical: true,
                    height: 30,
                  ),
                  FilledButton(
                    onPressed: data.saving
                        ? null
                        : () {
                            Navigator.maybePop(context);
                          },
                    child: const Text('Fechar'),
                  ),
                  FilledButton(
                    onPressed: data.saving ||
                            data.brand.toString() == data.editBrand.toString()
                        ? null
                        : () {
                            widget.controller.methods.saveBrand();
                          },
                    child: const Text('Salvar'),
                  ),
                ],
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final DisplayHelper displayHelper = DisplayHelper(context);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: displayHelper.lessThanMd ? 120 : 60,
                          child: Flex(
                            direction: displayHelper.lessThanMd
                                ? Axis.vertical
                                : Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller:
                                      widget.controller.form.nameController,
                                  onChanged: (value) => widget
                                      .controller.methods
                                      .updateBrandName(value),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    labelText: 'Nome da marca',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: displayHelper.moreThanSm ? 12 : null,
                                height: displayHelper.lessThanMd ? 8 : null,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller:
                                      widget.controller.form.websiteController,
                                  onChanged: (value) => widget
                                      .controller.methods
                                      .updateBrandWebsite(value),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    labelText: 'Website da marca',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: data.colorPickerExpanded
                              ? const Duration(milliseconds: 100)
                              : const Duration(milliseconds: 200),
                          height: getPickersHeight(displayHelper.lessThanMd,
                              data.colorPickerExpanded),
                          child: Flex(
                            direction: displayHelper.lessThanMd
                                ? Axis.vertical
                                : Axis.horizontal,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    BrandIconPicker(
                                      getUrl: (fileId) {
                                        return widget.controller.methods
                                            .getUrl(fileId);
                                      },
                                      filePickerController:
                                          widget.lightIconPickerController,
                                      onIconMirror: () {
                                        widget.controller.methods.setBrandIcon(
                                          data.editBrand.icon.light,
                                          true,
                                        );
                                      },
                                      brand: data.editBrand,
                                      dark: false,
                                      onIconSelected: (icon) {
                                        widget.controller.methods
                                            .updateBrandIcon(icon.id, false);
                                      },
                                    ),
                                    BrandColorPicker(
                                      dark: false,
                                      color: data.editBrand.color.light,
                                      brandColor: data.brand.color.light,
                                      onColorPickerExpansionToggled: () {
                                        widget.controller.methods
                                            .toggleColorPickerExpansion();
                                      },
                                      expanded: data.colorPickerExpanded,
                                      onColorPicked: (color) {
                                        widget.controller.methods
                                            .updateBrandIconBackground(
                                          color,
                                          false,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    BrandIconPicker(
                                      getUrl: (fileId) {
                                        return widget.controller.methods
                                            .getUrl(fileId);
                                      },
                                      filePickerController:
                                          widget.darkIconPickerController,
                                      onIconMirror: () {
                                        widget.controller.methods.setBrandIcon(
                                          data.editBrand.icon.dark,
                                          false,
                                        );
                                      },
                                      brand: data.editBrand,
                                      dark: true,
                                      onIconSelected: (icon) {
                                        widget.controller.methods
                                            .updateBrandIcon(icon.id, true);
                                      },
                                    ),
                                    BrandColorPicker(
                                      color: data.editBrand.color.dark,
                                      brandColor: data.brand.color.dark,
                                      dark: true,
                                      onColorPickerExpansionToggled: () {
                                        widget.controller.methods
                                            .toggleColorPickerExpansion();
                                      },
                                      expanded: data.colorPickerExpanded,
                                      onColorPicked: (color) {
                                        widget.controller.methods
                                            .updateBrandIconBackground(
                                          color,
                                          true,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
          eventListener: (context, event, data) {
            if (event.id == 'savingBrand') {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) {
                  return Center(
                    child: widget.controller.builder(
                      builder: (context, data) {
                        return const AppCard(
                          width: 400,
                          height: 150,
                          titleText: 'Salvando marca...',
                          contentPadding: EdgeInsets.all(12),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                      eventListener: (context, event, data) {
                        if (event.id == 'savedBrand') {
                          Navigator.maybePop(context);
                        }
                        if (event.id == 'errorDone') {
                          Navigator.maybePop(context);
                        }
                      },
                    ),
                  );
                },
              );
            }
            if (event.id == 'savedBrand') {
              Navigator.maybePop(context);
            }
          },
          allowAlertDialog: true,
        ),
      ),
    );
  }
}

double getPickersHeight(bool lessThanMd, bool expanded) {
  if (lessThanMd) {
    if (expanded) {
      return 1815;
    } else {
      return 885;
    }
  } else {
    if (expanded) {
      return 906;
    } else {
      return 441;
    }
  }
}

abstract class DarkIconPicker {}

abstract class LightIconPicker {}
