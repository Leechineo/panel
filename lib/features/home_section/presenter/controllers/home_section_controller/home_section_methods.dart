import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart';

class HomeSectionMethods {
  final void Function() addSection;
  final void Function(
    bool value,
    String sectionId,
  ) updateLinkedSectionValue;
  final void Function(
    bool value,
    ElementScreenSizes screenSize,
    String sectionId,
  ) updateHiddenValue;
  final void Function(
    Elements element,
    String sectionId,
  ) addElement;
  final void Function(
    FileReferenceEntity file,
    Element element,
  ) updateImage;
  final void Function(
    Elements elementType,
    Element element,
  ) addElementChild;
  final Element Function(Elements elementType) generateElement;
  final void Function(SectionEntity section) deleteSection;
  final void Function({
    required Element? element,
    SectionEntity? section,
    Element? parent,
  }) deleteElement;
  final Future<void> Function() onUpdate;

  HomeSectionMethods({
    required this.addSection,
    required this.updateLinkedSectionValue,
    required this.updateHiddenValue,
    required this.addElement,
    required this.updateImage,
    required this.addElementChild,
    required this.generateElement,
    required this.deleteSection,
    required this.deleteElement,
    required this.onUpdate,
  });
}
