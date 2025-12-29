import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:hexcolor/hexcolor.dart';

class BuildAndFloorTextTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const BuildAndFloorTextTile(
      {Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: HexColor('#f07857'),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
          color: HexColor(spaceManagementBuildingTowerFillColor),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: HexColor('#f07857'),
              ),
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: HexColor('#f07857'),
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
