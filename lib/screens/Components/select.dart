import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// final fruits = {
//   'l1': 'L1',
//   'l2': 'L2',
//   'l3': 'L3',
//   'm1': 'M1',
//   'm2': 'M2',
// };

// ignore: must_be_immutable
class InputSelect extends StatelessWidget {
  ValueChanged<String?>? getValueSelect;
  String label;
  Map<String, String> itemSelects;
  InputSelect({super.key,required this.label, required this.itemSelects, this.getValueSelect});

  @override
  Widget build(BuildContext context) {
    const borderSide = BorderSide(width: 0.4, color: Colors.grey);

    final theme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.displayMedium,
        ),
        const SizedBox(
          height: 4.00,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 180),
          child: ShadSelect<String>(
            decoration: const ShadDecoration(
                color: Colors.white,
                border: ShadBorder(
                    top: borderSide,
                    left: borderSide,
                    right: borderSide,
                    bottom: borderSide)),
            placeholder: Text(
              'Selectionner votre niveau',
              style: theme.displayMedium,
            ),
            options: [
              ...itemSelects.entries
                  .map((e) => ShadOption(value: e.key, child: Text(e.value))),
            ],
            selectedOptionBuilder: (context, value) => Text(
              itemSelects[value]!,
              style: theme.displayMedium,
            ),
            onChanged: getValueSelect,

            // onChanged: print,
          ),
        )
      ],
    );
  }
}
