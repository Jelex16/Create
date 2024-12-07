import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropDownSearch extends StatelessWidget {
  const DropDownSearch(
      {super.key,
      required this.items,
      required this.labelText,
      this.onChanged,
      this.selectedItem,
      this.showSearchBox = true});
  final List<String> items;
  final String labelText;
  final void Function(String?)? onChanged;
  final bool showSearchBox;

  final String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
            showSelectedItems: true, showSearchBox: showSearchBox),
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                //no border
                border: InputBorder.none,
                labelText: labelText,
                hintText: labelText,
                labelStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                hintStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            baseStyle: const TextStyle(
                color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        onChanged: onChanged,
        selectedItem: selectedItem,
      ),
    );
  }
}
