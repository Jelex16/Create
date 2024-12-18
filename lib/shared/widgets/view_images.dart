import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_home_client/providers/providers.dart';

class ViewImages extends ConsumerWidget {
  const ViewImages({
    super.key,
    this.imageFiles,
    this.text,
  });
  final List<File>? imageFiles;
  final String? text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listImagesInstance = ref.watch(loadImagesProvider.notifier);
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: size.width,
      height: size.height * 0.3,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
          )),
      child: (imageFiles == null || imageFiles!.isEmpty)
          ? Center(
              child: Text(
              text ?? 'No hay imagenes',
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ))
          : ListView(
              scrollDirection: Axis.horizontal,
              children: imageFiles!.map((imageFile) {
                return Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      height: 250,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(imageFile, fit: BoxFit.cover)),
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: IconButton(
                          onPressed: () {
                            listImagesInstance.deleteImage(
                              imageFiles!.indexOf(imageFile),
                            );
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        )),
                  ],
                );
              }).toList(),
            ),
    );
  }
}
