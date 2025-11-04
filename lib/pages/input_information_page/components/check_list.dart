import 'package:flutter/material.dart';

class CheckList extends StatelessWidget {
  final String checkName;
  final TextEditingController checkController;
  const CheckList({super.key, required this.checkName, required this.checkController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            checkName,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            width: 100,
            child: TextField(
              controller: checkController, //TODO: Connect Controller
              textAlign: TextAlign.end,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF0070F0))
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
