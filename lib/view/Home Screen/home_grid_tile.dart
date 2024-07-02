import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeGridTile extends StatelessWidget {
  final String title;
  final String image;
  final bool isAdmin;
  final bool isUserRightAvailable;
  final bool isScreenRightAvailable;
  final Function() onTap;

  HomeGridTile({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
    required this.isAdmin,
    required this.isUserRightAvailable,
    required this.isScreenRightAvailable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: isAdmin == false
              ? isUserRightAvailable
                  ? isScreenRightAvailable
                      ? onTap
                      : () {}
                  : () {}
              : onTap,
          child: Container(
            // width: size.width / 2.3,
            // height: size.height / 6,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            margin: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 35,
                  height: 35,
                  child: SvgPicture.asset(
                    image,
                    color: isAdmin == false
                        ? isUserRightAvailable
                            ? isScreenRightAvailable
                                ? Theme.of(context).primaryColor
                                : Colors.grey.withOpacity(0.5)
                            : Colors.grey.withOpacity(0.5)
                        : Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    color: mutedColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
