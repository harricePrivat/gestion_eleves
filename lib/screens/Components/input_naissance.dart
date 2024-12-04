import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class SingleDatePicker extends StatefulWidget {
   DateTime? dateTime;
  final ValueChanged<DateTime?>? dateChanged;

   SingleDatePicker({super.key, required this.dateTime, this.dateChanged});

  @override
  State<SingleDatePicker> createState() => _SingleDatePickerState();
}

class _SingleDatePickerState extends State<SingleDatePicker> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date de naissance: *",
          style: theme.displayMedium,
        ),
        const SizedBox(height: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ShadButton(
            decoration: const ShadDecoration(color: Colors.white),
            onPressed: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: widget.dateTime ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
              );
              if (pickedDate != null) {
                setState(() {
                  widget.dateTime = pickedDate;
                });
                widget.dateChanged?.call(pickedDate);
              }
            },
            child: Text(
              widget.dateTime != null
                  ? widget.dateTime!.toLocal().toString().split(' ')[0]
                  : "Entrez votre date de naissance",
              style: theme.titleSmall,
            ),
          ),
        ),
      ],
    );
  }
}
