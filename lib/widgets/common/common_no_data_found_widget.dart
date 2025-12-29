import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_gophygital_widgets/core/constants/font_constants.dart';

class CommonNoDataFoundWidget extends StatelessWidget {
  final String title;
  final String description;
  const CommonNoDataFoundWidget(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/vi_revamp/no_data_image.png',
            height: 170,
            width: 199,
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontFamily: FontConstants.viMedium,
                  fontSize: 16,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          Center(
            child: Text(
              description,
              style: const TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: FontConstants.viMedium,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
