import 'dart:convert';
import 'package:leechineo_panel/core/data/utils/app_id_generator_util.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/container_element.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/element_size.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/text_element.dart';
import 'package:leechineo_panel/features/home_section/domain/usecases/update_viewer_usecase.dart';
import 'package:leechineo_panel/features/home_section/presenter/controllers/home_section_controller/home_section_data.dart';
import 'package:leechineo_panel/features/home_section/presenter/controllers/home_section_controller/home_section_methods.dart';

class HomeSectionController
    extends AppController<HomeSectionData, HomeSectionMethods> {
  late final UpdateViewerUsecase _updateViewerUsecase;
  HomeSectionController({
    required UpdateViewerUsecase updateViewerUseCase,
  }) {
    _updateViewerUsecase = updateViewerUseCase;
  }
  @override
  HomeSectionData defineData() {
    return HomeSectionData(
      sections: [],
    );
  }

  @override
  HomeSectionMethods defineMethods() {
    return HomeSectionMethods(
      addSection: () {
        updateData(
          data.copyWith(
            sections: data.sections
              ..add(
                SectionEntity(
                  id: AppIdGenerator.gen(
                    prefix: 'section-',
                  ),
                  responsiviness: Responsiviness(
                    xs: ReponsivinessSectionOptions(
                      display: ElementDisplay.show,
                    ),
                    sm: ReponsivinessSectionOptions(
                      display: ElementDisplay.show,
                    ),
                    md: ReponsivinessSectionOptions(
                      display: ElementDisplay.show,
                    ),
                    lg: ReponsivinessSectionOptions(
                      display: ElementDisplay.show,
                    ),
                    xl: ReponsivinessSectionOptions(
                      display: ElementDisplay.show,
                    ),
                    xxl: ReponsivinessSectionOptions(
                      display: ElementDisplay.show,
                    ),
                    linked: true,
                  ),
                  elements: [],
                  createdAt: DateTime.now(),
                ),
              ),
          ),
        );
        methods.onUpdate();
      },
      updateLinkedSectionValue: (bool value, String sectionId) {
        final filteredSection = data.sections.where(
          (element) => element.id == sectionId,
        );
        if (filteredSection.isNotEmpty) {
          final currentSection = filteredSection.first;
          final sectionIndex = data.sections.indexOf(currentSection);
          final updatedSections = data.sections;
          updatedSections[sectionIndex].responsiviness.linked = value;
          updateData(
            data.copyWith(
              sections: updatedSections,
            ),
          );
        }
        methods.onUpdate();
      },
      updateHiddenValue: (value, screenSize, sectionId) {
        ElementDisplay displayValue() {
          if (value) {
            return ElementDisplay.hidden;
          }
          return ElementDisplay.show;
        }

        Responsiviness<ReponsivinessSectionOptions> updateValue(
          SectionEntity section,
        ) {
          switch (screenSize) {
            case ElementScreenSizes.xs:
              return section.responsiviness.copyWith(
                xs: ReponsivinessSectionOptions(
                  display: displayValue(),
                ),
              );
            case ElementScreenSizes.sm:
              return section.responsiviness.copyWith(
                sm: ReponsivinessSectionOptions(
                  display: displayValue(),
                ),
              );
            case ElementScreenSizes.md:
              return section.responsiviness.copyWith(
                md: ReponsivinessSectionOptions(
                  display: displayValue(),
                ),
              );
            case ElementScreenSizes.lg:
              return section.responsiviness.copyWith(
                lg: ReponsivinessSectionOptions(
                  display: displayValue(),
                ),
              );
            case ElementScreenSizes.xl:
              return section.responsiviness.copyWith(
                xl: ReponsivinessSectionOptions(
                  display: displayValue(),
                ),
              );
            case ElementScreenSizes.xxl:
              return section.responsiviness.copyWith(
                xxl: ReponsivinessSectionOptions(
                  display: displayValue(),
                ),
              );
          }
        }

        final filteredSection =
            data.sections.where((element) => element.id == sectionId);
        if (filteredSection.isNotEmpty) {
          final currentSection = filteredSection.first;
          final sectionIndex = data.sections.indexOf(currentSection);
          final updatedSections = data.sections;
          updatedSections[sectionIndex].responsiviness =
              updateValue(currentSection);
          updateData(
            data.copyWith(
              sections: updatedSections,
            ),
          );
        }
        methods.onUpdate();
      },
      generateElement: (elementType) {
        defaultFlexResponsiviness() => ResponsivinessFlexOptions(
              display: ElementDisplay.show,
              align: ElementAlignment.start,
              justify: ElementAlignment.start,
            );
        defaultContainerResposiviness() => ResponsivinessContainerOptions(
              width: ElementSize.fixed(300),
              height: ElementSize.noSet(),
              display: ElementDisplay.show,
              overflow: ElementOverflow.wrap,
              margin: ElementSpacing.zero(),
              padding: ElementSpacing.zero(),
            );
        defaultImageResponsiviness() => ResponsivinessImageOptions(
              width: ElementSize.fixed(300),
              height: ElementSize.noSet(),
              blurLevel: 0,
            );
        defaultTextResponsiviness() => ResponsivinessTextOptions(
              display: ElementDisplay.show,
              style: TextElementStyle(
                fontSize: 16,
                fontWeight: 400,
                fontStyle: TextElementFontStyle.normal,
                letterSpacing: 0.2,
                wordSpacing: 0.8,
                lineHeight: 1.4,
                decorarion: TextElementDecorarion.none,
                color: null,
                decorationColor: null,
                align: TextElementAlign.start,
                decorationStyle: TextElementDecorationStyle.solid,
              ),
            );
        switch (elementType) {
          case Elements.column:
            return ColumnElement(
              id: AppIdGenerator.gen(prefix: 'column-'),
              responsiviness: Responsiviness(
                xs: defaultFlexResponsiviness(),
                sm: defaultFlexResponsiviness(),
                md: defaultFlexResponsiviness(),
                lg: defaultFlexResponsiviness(),
                xl: defaultFlexResponsiviness(),
                xxl: defaultFlexResponsiviness(),
                linked: true,
              ),
              children: [],
            );
          case Elements.row:
            return RowElement(
              id: AppIdGenerator.gen(prefix: 'row-'),
              responsiviness: Responsiviness(
                xs: defaultFlexResponsiviness(),
                sm: defaultFlexResponsiviness(),
                md: defaultFlexResponsiviness(),
                lg: defaultFlexResponsiviness(),
                xl: defaultFlexResponsiviness(),
                xxl: defaultFlexResponsiviness(),
                linked: true,
              ),
              children: [],
            );
          case Elements.container:
            return ContainerElement(
              id: AppIdGenerator.gen(prefix: 'container-'),
              responsiviness: Responsiviness(
                xs: defaultContainerResposiviness(),
                sm: defaultContainerResposiviness(),
                md: defaultContainerResposiviness(),
                lg: defaultContainerResposiviness(),
                xl: defaultContainerResposiviness(),
                xxl: defaultContainerResposiviness(),
                linked: true,
              ),
              color: ElementColor(
                light: '',
                dark: '',
              ),
              child: null,
            );
          case Elements.image:
            return ImageElement(
              id: AppIdGenerator.gen(prefix: 'image-'),
              fileId: null,
              responsiviness: Responsiviness(
                xs: defaultImageResponsiviness(),
                sm: defaultImageResponsiviness(),
                md: defaultImageResponsiviness(),
                lg: defaultImageResponsiviness(),
                xl: defaultImageResponsiviness(),
                xxl: defaultImageResponsiviness(),
                linked: true,
              ),
              child: null,
            );
          case Elements.text:
            return TextElement(
              id: AppIdGenerator.gen(prefix: 'text-'),
              responsiviness: Responsiviness(
                xs: defaultTextResponsiviness(),
                sm: defaultTextResponsiviness(),
                md: defaultTextResponsiviness(),
                lg: defaultTextResponsiviness(),
                xl: defaultTextResponsiviness(),
                xxl: defaultTextResponsiviness(),
                linked: true,
              ),
              color: ElementColor(
                light: '',
                dark: '',
              ),
              content: '',
            );
          case Elements.link:
            return ContainerElement(
              id: AppIdGenerator.gen(
                prefix: 'link-',
              ),
              responsiviness: Responsiviness(
                xs: defaultContainerResposiviness(),
                sm: defaultContainerResposiviness(),
                md: defaultContainerResposiviness(),
                lg: defaultContainerResposiviness(),
                xl: defaultContainerResposiviness(),
                xxl: defaultContainerResposiviness(),
                linked: true,
              ),
              color: ElementColor(
                light: '',
                dark: 'dark',
              ),
              child: null,
            );
        }
      },
      addElement: (Elements element, String sectionId) {
        final sectionFiltered = data.sections.where(
          (element) => element.id == sectionId,
        );

        if (sectionFiltered.isNotEmpty) {
          final sectionIndex = data.sections.indexOf(sectionFiltered.first);
          final section = sectionFiltered.first;
          section.elements.add(methods.generateElement(element));
          final sections = data.sections;
          sections[sectionIndex] = section;
          updateData(
            data.copyWith(
              sections: sections,
            ),
          );
        }
        methods.onUpdate();
      },
      addElementChild: (elementType, element) {
        if (element.children != null) {
          element.children!.add(
            methods.generateElement(
              elementType,
            ),
          );
        } else {
          element.child = methods.generateElement(
            elementType,
          );
        }
        updateData(data);
        methods.onUpdate();
      },
      updateImage: (file, element) {
        if (element is ImageElement) {
          element.fileId = file.id;
        }
        updateData(data);
        methods.onUpdate();
      },
      deleteSection: (section) {
        data.sections.remove(section);
        updateData(data);
        methods.onUpdate();
      },
      deleteElement: ({parent, section, required element}) {
        if (section != null && section.elements.contains(element)) {
          section.elements.remove(element);
          updateData(data);
          methods.onUpdate();
          return;
        }
        if (parent?.children != null && parent!.children!.contains(element)) {
          parent.children!.remove(element);
          updateData(data);
          methods.onUpdate();
          return;
        }
        if (parent != null && parent.child == element) {
          parent.child = null;
          updateData(data);
        }
        methods.onUpdate();
      },
      onUpdate: () async {
        final jsonString = jsonEncode({
          'updatedAt': DateTime.now().toIso8601String(),
          'sections': data.sections.map((section) => section.toMap()).toList(),
        });
        await _updateViewerUsecase.exec(jsonString);
      },
    );
  }
}
