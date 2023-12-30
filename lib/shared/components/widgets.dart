import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../view/modules/web_view_flutter.dart';

// default form in app
Widget formFieldWidget({
  final TextEditingController? controller,
  final String? labelText,
  final String? hintText,
  final String? helperText,
  final bool isPassword = false,
  final FormFieldValidator<String>? validMsg,
  final ValueChanged<String>? onSubmits,
  final ValueChanged<String>? onChanged,
  final TextInputType? type,
  final Widget? prefixIcon,
  final Widget? suffixIcon,
  final VoidCallback? suffixPressed,
  required BuildContext context,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    onFieldSubmitted: onSubmits,
    onChanged: onChanged,
    obscureText: isPassword,
    // ignore: prefer_const_constructors
    decoration: InputDecoration(
      // prefixIconColor: Colors.white,
      // suffixIconColor: Colors.white,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon != null
          ? IconButton(onPressed: suffixPressed, icon: suffixIcon)
          : null,
      labelText: labelText,
      suffixStyle: Theme.of(context).textTheme.labelLarge,
      labelStyle: Theme.of(context).textTheme.labelLarge,
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.labelLarge,
      helperText: helperText,
      helperStyle: Theme.of(context).textTheme.labelLarge,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    validator: validMsg,
  );
}

navigateToScreen({required Widget screen, required BuildContext context}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

Widget buildArticleItems({required article, required context}) => InkWell(
      onTap: () async {
        /**
         * these lise of code for 
         * if user use the android or ios go to webview 
         * if else this like web, run the aricale on the browser
         */
        if (defaultTargetPlatform == TargetPlatform.android) {
          navigateToScreen(
            screen: WebViewNewsScreen(
              url: article['url'],
            ),
            context: context,
          );
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          navigateToScreen(
            screen: WebViewNewsScreen(
              url: article['url'],
            ),
            context: context,
          );
        } else {
          Uri url = Uri.parse(article['url']);
          if (!await launchUrl(url)) {
            throw Exception('Could not launch $url');
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            /// image of news
            Container(
              width: 120.spMin,
              height: 120.spMin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: article['urlToImage'] != null
                    ? DecorationImage(
                        image: NetworkImage('${article['urlToImage']}'),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'),
                      ),
              ),
            ),
            SizedBox(width: 20.spMin),
            Expanded(
              child: Container(
                height: 130.spMin,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        '${article['title']}',
                        maxLines: 100,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.spMax),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        DateFormat().add_yMMMMEEEEd().format(
                              DateTime.parse(
                                article['publishedAt'],
                              ),
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildArticle(
        {required list, required int itemCount, isSearch = false}) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItems(
          article: list[index],
          context: context,
        ),
        separatorBuilder: (context, index) => dividerWidget(),
        itemCount: itemCount,
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );

Widget dividerWidget() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    );

Widget pSizeBoxHeight20() => SizedBox(height: 20.sp);

Widget pSizeBoxWidth10() => SizedBox(width: 10.sp);
