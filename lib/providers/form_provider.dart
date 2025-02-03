
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/models/form_field_model.dart';

final jsonDesignProvider = StateProvider<String>((ref) => '''[
  { "field_name": "f1", "widget": "dropdown", "valid_values": ["A", "B"] },
  { "field_name": "f2", "widget": "textfield", "visible": "f1=='A'" },
  { "field_name": "f3", "widget": "textfield", "visible": "f1=='A'" },
  { "field_name": "f4", "widget": "textfield", "visible": "f1=='A'" },
  { "field_name": "f5", "widget": "textfield", "visible": "f1=='B'" },
  { "field_name": "f6", "widget": "textfield", "visible": "f1=='B'" }
]''');

final userDataProvider = StateProvider<Map<String, dynamic>>((ref) => {});

final formFieldsProvider = Provider<List<FormFieldModel>>((ref) {
  final jsonDesign = ref.watch(jsonDesignProvider);
  try {
    final List<dynamic> decoded = json.decode(jsonDesign);
    return decoded.map((field) => FormFieldModel.fromJson(field)).toList();
  } catch (e) {
    return [];
  }
});
