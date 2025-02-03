

import 'package:dynamic_form_builder/providers/form_provider.dart';
import 'package:dynamic_form_builder/screens/widgets/dynamic_form.dart';
import 'package:dynamic_form_builder/screens/widgets/json_editor.dart';
import 'package:dynamic_form_builder/screens/widgets/user_data_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DynamicFormScreen extends ConsumerWidget {
  const DynamicFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fields = ref.watch(formFieldsProvider);
    final userData = ref.watch(userDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Form Builder'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: JsonEditor(
                      provider: jsonDesignProvider,
                      label: 'Design JSON',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: UserDataViewer(userData: userData),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 2,
              child: DynamicForm(fields: fields, userData: userData),
            ),
          ],
        ),
      ),
    );
  }
}
