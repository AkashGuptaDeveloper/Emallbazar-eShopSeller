//======================= AppBar Widget ========================================
import 'package:flutter/material.dart';
import '../Helper/Color.dart';
import '../Helper/Constant.dart';
import '../Provider/settingProvider.dart';
import 'desing.dart';

getAppBar(
  String title,
  BuildContext context,
) {
  return AppBar(
    titleSpacing: 0,
    backgroundColor: white,
    leading: Builder(
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: DesignConfiguration.shadow(),
          child: InkWell(
            borderRadius: BorderRadius.circular(circularBorderRadius5),
            onTap: () => Navigator.of(context).pop(),
            child: const Center(
              child: Icon(
                Icons.keyboard_arrow_left,
                color: primary,
                size: 30,
              ),
            ),
          ),
        );
      },
    ),
    title: Text(
      title,
      style: const TextStyle(
        color: grad2Color,
      ),
    ),
  );
}

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GradientAppBar(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [grad1Color, grad2Color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
          tileMode: TileMode.clamp,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(circularBorderRadius10),
          bottomRight: Radius.circular(circularBorderRadius10),
        ),
      ),
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).padding.top + 40,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 15.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: white,
                      size: 25,
                    ),
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 9.0,
                      start: 15,
                      end: 15,
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        color: white,
                        fontSize: textFontSize16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(width, 50);
}
