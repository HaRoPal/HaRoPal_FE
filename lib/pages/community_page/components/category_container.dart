import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haropal/controllers/specific_page_controller.dart';

import '../../../controllers/community_controller.dart';
import '../../specific_statistics_page/specific_statistics_page.dart';


class CategoryContainer extends StatelessWidget {
  final String categoryName;
  final String categoryImagePath;
  const CategoryContainer({
    super.key,
    required this.categoryName,
    required this.categoryImagePath
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: GestureDetector(
        onTap: () {
          final controller = Get.find<SpecificPageController>();
          controller.fetchSpecificWorkoutFromCategory(categoryName);
          Get.to(() => SpecificStatisticsPage());
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFF2F8FF),
          ),
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(
                        categoryImagePath,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  categoryName,
                  style: TextStyle(
                      color: Color(0xFF006BE5),
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
