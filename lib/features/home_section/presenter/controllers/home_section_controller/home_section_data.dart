import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart';

class HomeSectionData extends AppControllerData {
  final List<SectionEntity> sections;

  HomeSectionData({
    required this.sections,
  });

  @override
  String toString() => 'HomeSectionData(sections: $sections)';

  @override
  HomeSectionData copyWith({
    List<SectionEntity>? sections,
  }) {
    return HomeSectionData(
      sections: sections ?? this.sections,
    );
  }
}
