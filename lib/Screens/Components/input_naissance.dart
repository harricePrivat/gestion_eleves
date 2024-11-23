import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SingleDatePicker extends StatelessWidget {
  const SingleDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    const borderSide = BorderSide(width: 0.4, color: Colors.grey);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date de naissance: *",
          style: theme.displayMedium,
        ),
        const SizedBox(
          height: 4,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ShadDatePicker(
            foregroundColor: Colors.grey,
            placeholder: const Text(
              "Cliquez pour selectionner une date",
              style: TextStyle(color: Colors.grey),
            ),
            calendarHeaderTextStyle: theme.bodyMedium,
            closeOnSelection: true,
            selectedDayButtonTextStyle: theme.displayMedium,
            decoration: const ShadDecoration(
                color: Colors.white,
                border: ShadBorder(
                    top: borderSide,
                    left: borderSide,
                    right: borderSide,
                    bottom: borderSide)),
          ),
        )
      ],
    );
  }
}
