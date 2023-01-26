import 'package:flutter/material.dart';

const List<String> list = ['Guru', 'Orang Tua'];

class RoleDropdown extends StatefulWidget {
  const RoleDropdown({super.key});

  @override
  State<StatefulWidget> createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String dropdownValues = list.first;
  String holder = '';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValues,
      elevation: 16,
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? value) {
        setState(
          () {
            dropdownValues = value!;
          },
        );
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void getDropDownItem() {
    setState(() {
      holder = dropdownValues;
    });
  }
}
