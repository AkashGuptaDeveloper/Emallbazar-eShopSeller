import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellermultivendor/Screen/FAQ/faq.dart';
import '../../../Helper/Color.dart';
import '../../../Helper/Constant.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/validation.dart';

class GetMediaWidget extends StatelessWidget {
  final int index;
  final String id;
  final Function update;
  final BuildContext perentcontext;

  const GetMediaWidget({
    Key? key,
    required this.index,
    required this.update,
    required this.id,
    required this.perentcontext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(circularBorderRadius5)),
          color: white,
          // boxShadow: [
          //   BoxShadow(
          //     color: blarColor,
          //     offset: Offset(0, 0),
          //     blurRadius: 4,
          //     spreadRadius: 0,
          //   ),
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 15,
            left: 15,
            top: 10.0,
            bottom: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Icon(
              //   Icons.radio_button_checked_outlined,
              //   color: primary,
              //   size: 20,
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 5,
                    left: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Q:  ',
                                  style: TextStyle(
                                    color: black.withOpacity(0.6),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PlusJakartaSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    faqProvider!.tagList[index].question!,
                                    style: const TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "PlusJakartaSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 05,
                            ),
                            Row(
                              children: [
                                Text(
                                  'A:  ',
                                  style: TextStyle(
                                    color: black.withOpacity(0.6),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PlusJakartaSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  faqProvider!.tagList[index].answer!.isNotEmpty
                                      ? faqProvider!.tagList[index].answer!
                                      : getTranslated(
                                          context, "No Answer Yet..!")!,
                                  style: TextStyle(
                                    color: black.withOpacity(0.6),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PlusJakartaSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     faqProvider!.deleteTagsAPI(
                      //       faqProvider!.tagList[index].id,
                      //       context,
                      //     );
                      //     Future.delayed(const Duration(seconds: 2)).then(
                      //       (_) async {
                      //         faqProvider!.scrollLoadmore = true;
                      //         faqProvider!.scrollOffset = 0;
                      //         faqProvider!.getFaQs(perentcontext, update, id);
                      //         update();
                      //       },
                      //     );
                      //   },
                      //   child: const Icon(
                      //     Icons.delete,
                      //     color: primary,
                      //     size: 20,
                      //   ),≥
                      // ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                    faqProvider!.deleteTagsAPI(
                      faqProvider!.tagList[index].id,
                      context,
                    );
                    Future.delayed(const Duration(seconds: 2)).then(
                      (_) async {
                        faqProvider!.scrollLoadmore = true;
                        faqProvider!.scrollOffset = 0;
                        faqProvider!.getFaQs(perentcontext, update, id);
                        update();
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    DesignConfiguration.setNewSvgPath('Delete'),
                    width: 20,
                    height: 20,
                    colorFilter:
                        const ColorFilter.mode(primary, BlendMode.srcIn),
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
