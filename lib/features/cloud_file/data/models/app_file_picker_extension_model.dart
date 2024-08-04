class AppFilePickerExtension<V> {
  final String type;

  AppFilePickerExtension(this.type);

  static AppFilePickerExtension png = AppFilePickerExtension('png');
  static AppFilePickerExtension jpg = AppFilePickerExtension('jpg');
  static AppFilePickerExtension svg = AppFilePickerExtension('svg');
  static AppFilePickerExtension jpeg = AppFilePickerExtension('jpeg');
  static AppFilePickerExtension pdf = AppFilePickerExtension('pdf');
}
