import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: must_be_immutable
class PickImages extends StatefulWidget {
  XFile? images;
  GestureTapCallback onPicked;
  String name;

  PickImages(
      {super.key,
        required this.images,
      required this.onPicked,
      required this.name});

  @override
  State<PickImages> createState() => _PickImagesState();
}

class _PickImagesState extends State<PickImages> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: widget.onPicked,
          child: Container(
            // width: 200,
            //  / height: 25,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color.fromARGB(255, 220, 220, 220),
                border: Border.all(width: 0.001, color: Colors.grey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.add),
                Expanded(
                    child: Text(
                  widget.name,
                  style: theme.titleMedium,
                ))
              ],
            ),
          ),
        ),
        widget.images == null
            ? Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Aucune photo selectionée",
                      style: GoogleFonts.lato(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ],
                ))
            : Padding(
                padding: const EdgeInsets.all(16.00),
                child: Stack(
                  children: [
                    Image.file(File(widget.images!.path)),
                    Positioned(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.images = null;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                            )))
                  ],
                )),
      ],
    );
  }
}
