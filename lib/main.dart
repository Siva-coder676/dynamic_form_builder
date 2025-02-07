import 'package:dynamic_form_builder/screens/dynamic_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const DynamicFormScreen(),
    );
  }
}





// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
// // 
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//       ),
//       home: const DynamicFormScreen(),
//     );
//   }
// }

// class DynamicFormScreen extends ConsumerWidget {
//   const DynamicFormScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final fields = ref.watch(formFieldsProvider);
//     final userData = ref.watch(userDataProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dynamic Form Builder'),
//         backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: JsonEditor(
//                       provider: jsonDesignProvider,
//                       label: 'Design JSON',
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: UserDataViewer(userData: userData),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               flex: 2,
//               child: DynamicForm(
//                 fields: fields,
//                 userData: userData,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class JsonEditor extends ConsumerWidget {
//   final StateProvider<String> provider;
//   final String label;

//   const JsonEditor({
//     super.key,
//     required this.provider,
//     required this.label,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final jsonValue = ref.watch(provider);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         const SizedBox(height: 8),
//         Expanded(
//           child: TextField(
//             controller: TextEditingController(text: jsonValue)
//               ..selection = TextSelection.fromPosition(
//                 TextPosition(offset: jsonValue.length),
//               ),
//             maxLines: null,
//             expands: true,
//             decoration: InputDecoration(
//               border: const OutlineInputBorder(),
//               filled: true,
//               fillColor: Theme.of(context).colorScheme.surface,
//             ),
//             onChanged: (value) => ref.read(provider.notifier).state = value,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class UserDataViewer extends StatelessWidget {
//   final Map<String, dynamic> userData;

//   const UserDataViewer({
//     super.key,
//     required this.userData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'User Data',
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         const SizedBox(height: 8),
//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               border: Border.all(color: Theme.of(context).colorScheme.outline),
//               borderRadius: BorderRadius.circular(4),
//               color: Theme.of(context).colorScheme.surface,
//             ),
//             child: SingleChildScrollView(
//               child: Text(
//                 const JsonEncoder.withIndent('  ').convert(userData),
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       fontFamily: 'monospace',
//                     ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class DynamicForm extends ConsumerWidget {
//   final List<FormField> fields;
//   final Map<String, dynamic> userData;

//   const DynamicForm({
//     super.key,
//     required this.fields,
//     required this.userData,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Card(
//       child: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: fields.length,
//         separatorBuilder: (context, index) => const SizedBox(height: 16),
//         itemBuilder: (context, index) {
//           final field = fields[index];
//           if (field.visible != null && !_isFieldVisible(field, userData)) {
//             return const SizedBox.shrink();
//           }
//           return _buildField(field, userData, ref);
//         },
//       ),
//     );
//   }

//   bool _isFieldVisible(FormField field, Map<String, dynamic> userData) {
//     if (field.visible == null) return true;

//     final parts = field.visible!.split('==');
//     if (parts.length != 2) return false;

//     final fieldName = parts[0].trim();
//     final expectedValue = parts[1].replaceAll("'", '').trim();

//     return userData[fieldName] == expectedValue;
//   }

//   Widget _buildField(
//       FormField field, Map<String, dynamic> userData, WidgetRef ref) {
//     switch (field.widget) {
//       case 'dropdown':
//         return DropdownButtonFormField<String>(
//           value: userData[field.fieldName],
//           items: field.validValues?.map((value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (newValue) {
//             _updateUserData(field.fieldName, newValue, ref);
//           },
//           decoration: InputDecoration(
//             labelText: field.fieldName,
//             border: const OutlineInputBorder(),
//           ),
//         );
//       case 'textfield':
//         return TextFormField(
//           initialValue: userData[field.fieldName],
//           onChanged: (value) {
//             _updateUserData(field.fieldName, value, ref);
//           },
//           decoration: InputDecoration(
//             labelText: field.fieldName,
//             border: const OutlineInputBorder(),
//           ),
//         );
//       default:
//         return const SizedBox.shrink();
//     }
//   }

//   void _updateUserData(String key, dynamic value, WidgetRef ref) {
//     ref.read(userDataProvider.notifier).update((state) => {
//           ...state,
//           key: value,
//         });
//   }
// }

// // Models
// class FormField {
//   final String fieldName;
//   final String widget;
//   final List<String>? validValues;
//   final String? visible;

//   FormField({
//     required this.fieldName,
//     required this.widget,
//     this.validValues,
//     this.visible,
//   });

//   factory FormField.fromJson(Map<String, dynamic> json) {
//     return FormField(
//       fieldName: json['field_name'],
//       widget: json['widget'],
//       validValues: json['valid_values']?.cast<String>(),
//       visible: json['visible'],
//     );
//   }
// }

// // Providers
// final jsonDesignProvider = StateProvider<String>((ref) => '''[
//   { "field_name": "f1", "widget": "dropdown", "valid_values": ["A", "B"] },
//   { "field_name": "f2", "widget": "textfield", "visible": "f1=='A'" },
//   { "field_name": "f3", "widget": "textfield", "visible": "f1=='A'" },
//   { "field_name": "f4", "widget": "textfield", "visible": "f1=='A'" },
//   { "field_name": "f5", "widget": "textfield", "visible": "f1=='B'" },
//   { "field_name": "f6", "widget": "textfield", "visible": "f1=='B'" }
// ]''');

// final userDataProvider = StateProvider<Map<String, dynamic>>((ref) => {});

// final formFieldsProvider = Provider<List<FormField>>((ref) {
//   final jsonDesign = ref.watch(jsonDesignProvider);
//   try {
//     final List<dynamic> decoded = json.decode(jsonDesign);
//     return decoded.map((field) => FormField.fromJson(field)).toList();
//   } catch (e) {
//     return [];
//   }
// });
