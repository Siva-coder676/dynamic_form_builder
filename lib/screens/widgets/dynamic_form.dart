import 'package:dynamic_form_builder/core/models/form_field_model.dart';
import 'package:dynamic_form_builder/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicForm extends ConsumerWidget {
  final List<FormFieldModel> fields;
  final Map<String, dynamic> userData;

  const DynamicForm({super.key, required this.fields, required this.userData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: fields.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final field = fields[index];
          if (field.visible != null && !_isFieldVisible(field, userData)) {
            return const SizedBox.shrink();
          }
          return _buildField(field, userData, ref);
        },
      ),
    );
  }

  bool _isFieldVisible(FormFieldModel field, Map<String, dynamic> userData) {
    if (field.visible == null) return true;
    final parts = field.visible!.split('==');
    return parts.length == 2 &&
        userData[parts[0].trim()] == parts[1].replaceAll("'", '').trim();
  }

  Widget _buildField(
      FormFieldModel field, Map<String, dynamic> userData, WidgetRef ref) {
    switch (field.widget) {
      case 'dropdown':
        return DropdownButtonFormField<String>(
          value: userData[field.fieldName],
          items: field.validValues
              ?.map((value) =>
                  DropdownMenuItem<String>(value: value, child: Text(value)))
              .toList(),
          onChanged: (newValue) => ref
              .read(userDataProvider.notifier)
              .update((state) => {...state, field.fieldName: newValue}),
          decoration: InputDecoration(
              labelText: field.fieldName, border: const OutlineInputBorder()),
        );
      case 'textfield':
        return TextFormField(
          initialValue: userData[field.fieldName],
          onChanged: (value) => ref
              .read(userDataProvider.notifier)
              .update((state) => {...state, field.fieldName: value}),
          decoration: InputDecoration(
              labelText: field.fieldName, border: const OutlineInputBorder()),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
