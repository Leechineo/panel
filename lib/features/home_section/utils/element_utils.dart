import 'package:leechineo_panel/features/home_section/domain/entities/container_element.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart';

class ElementUtils {
  Responsiviness<T> responsivinessFromMap<T extends ResponsivinessItem>(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic> map) mapper,
  ) {
    return Responsiviness<T>(
      xs: mapper(map['xs']),
      sm: mapper(map['sm']),
      md: mapper(map['md']),
      lg: mapper(map['lg']),
      xl: mapper(map['xl']),
      xxl: mapper(map['xxl']),
      linked: map['linked'],
    );
  }

  Element elementFromMap(Map<String, dynamic> map) {
    switch (map['elementType']) {
      case 'row':
        return rowElementFromMap(map);
      case 'column':
        return columnElementFromMap(map);
      default:
        return containerFromMap(map);
    }
  }

  // Container
  ResponsivinessContainerOptions responsivinessContainerOptionsFromMap(
    Map<String, dynamic> map,
  ) {
    return ResponsivinessContainerOptions(
      width: map['width'],
      height: map['height'],
      display: map['display'],
      margin: map['margin'],
      padding: map['padding'],
      overflow: map['overflow'],
    );
  }

  ContainerElement containerFromMap(Map<String, dynamic> map) {
    return ContainerElement(
      id: map['id'],
      responsiviness: responsivinessFromMap<ResponsivinessContainerOptions>(
        map['responsiviness'],
        responsivinessContainerOptionsFromMap,
      ),
      color: ElementColor.fromMap(map['color']),
      child: elementFromMap(map['child']),
    );
  }

  // Flex
  List<Element> flexChildrenFromMap(List elements) {
    return elements.map((element) => elementFromMap(element)).toList();
  }

  ResponsivinessFlexOptions responsivinessFlexOptionsFromMap(
    Map<String, dynamic> map,
  ) {
    return ResponsivinessFlexOptions(
      display: map['display'],
      align: map['align'],
      justify: map['justify'],
    );
  }

  RowElement rowElementFromMap(Map<String, dynamic> map) {
    return RowElement(
      id: map['id'],
      responsiviness: responsivinessFromMap<ResponsivinessFlexOptions>(
          map['responsiviness'], responsivinessFlexOptionsFromMap),
      children: flexChildrenFromMap(map['children']),
    );
  }

  ColumnElement columnElementFromMap(Map<String, dynamic> map) {
    return ColumnElement(
      id: map['id'],
      responsiviness: responsivinessFromMap<ResponsivinessFlexOptions>(
          map['responsiviness'], responsivinessFlexOptionsFromMap),
      children: flexChildrenFromMap(map['children']),
    );
  }
}
