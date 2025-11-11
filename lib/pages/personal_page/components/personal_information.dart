import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../input_information_page/change_information_page.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // TODO: Apply actual Image
            CircleAvatar(
              radius: 40,
              // backgroundImage: Images(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'User1',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  //TODO: Apply actual value (Level)
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      'Lv.45',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0070F0)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Get.off(() => ChangeInformationPage());
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color(0xFF909090)
                      ),
                    ),
                  ),
                  child: Text(
                    "개인 정보 수정",
                    style: TextStyle(
                      color: Color(0xFF909090),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //TODO: Apply actual value (Percentage for next level)
        const LinearProgressIndicator(
          value: 0.30,
          backgroundColor: Color(0xFF80B7F7),
          color: Color(0xFF0070F0),
        ),
        //TODO: Apply actual value (Current XP / Max XP)
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '300/1000xp',
              style: TextStyle(
                  color: Color(0xFF0070F0)
              ),
            ),
          ],
        ),
      ],
    );
  }
}


