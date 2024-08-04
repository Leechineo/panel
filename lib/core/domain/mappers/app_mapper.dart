abstract class AppMapper<DTO, Entity> {
  DTO fromMapToDTO(Map<String, dynamic> map);
  Entity fromMapToEntity(Map<String, dynamic> map);
  Map<String, dynamic> fromEntityToMap(Entity entity);
  Map<String, dynamic> fromDTOToMap(DTO dto);

  DTO fromEntityToDTO(Entity entity) {
    final map = fromEntityToMap(entity);
    final dto = fromMapToDTO(map);
    return dto;
  }

  Entity fromDTOToEntity(DTO dto) {
    final map = fromDTOToMap(dto);
    final entity = fromMapToEntity(map);
    return entity;
  }
}
