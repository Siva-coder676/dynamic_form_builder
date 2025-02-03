
class FormFieldModel {
  final String fieldName;
  final String widget;
  final List<String>? validValues;
  final String? visible;

  FormFieldModel({
    required this.fieldName,
    required this.widget,
    this.validValues,
    this.visible,
  });

  factory FormFieldModel.fromJson(Map<String, dynamic> json) {
    return FormFieldModel(
      fieldName: json['field_name'],
      widget: json['widget'],
      validValues: json['valid_values']?.cast<String>(),
      visible: json['visible'],
    );
  }
}
