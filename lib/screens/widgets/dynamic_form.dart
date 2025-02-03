
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
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: fields.length,
        itemBuilder: (context, index) {
          final field = fields[index];

          if (field.visible != null && userData[field.fieldName] != field.visible) {
            return const SizedBox.shrink();
          }

          return TextFormField(
            decoration: InputDecoration(
              labelText: field.fieldName,
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              ref.read(userDataProvider.notifier).state[field.fieldName] = value;
            },
          );
        },
      ),
    );
  }
}
