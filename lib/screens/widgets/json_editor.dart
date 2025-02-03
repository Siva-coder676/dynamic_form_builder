
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JsonEditor extends ConsumerWidget {
  final StateProvider<String> provider;
  final String label;

  const JsonEditor({super.key, required this.provider, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonValue = ref.watch(provider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: TextField(
            controller: TextEditingController(text: jsonValue)
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: jsonValue.length),
              ),
            maxLines: null,
            expands: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => ref.read(provider.notifier).state = value,
          ),
        ),
      ],
    );
  }
}
