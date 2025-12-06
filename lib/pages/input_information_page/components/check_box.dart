import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/input_information_controller.dart';

class CheckBox extends StatefulWidget {
  final String checkName;
  const CheckBox({super.key, required this.checkName});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InputInformationController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.checkName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButton<String>(
              value: controller.gender.value,
              hint: const Text("선택"),
              dropdownColor: Colors.white,
              underline: SizedBox(),
              items: ["남자", "여자"].map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(value),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  controller.gender.value = newValue!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}