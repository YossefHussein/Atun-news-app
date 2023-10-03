import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

// Widget buildArticle({
//   required dynamic? article,
//   required BuildContext context,
// }) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//     child: Row(
//       children: [
//         Expanded(
//           child: Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               image: article['urlToImage'] != null
//                   ? DecorationImage(
//                       image: NetworkImage('${article['urlToImage']}'),
//                       fit: BoxFit.cover)
//                   : DecorationImage(
//                       image: NetworkImage(
//                           'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'),
//                       scale: 1,
//                       fit: BoxFit.cover,
//                     ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 20),
//         Expanded(
//           child: Container(
//             height: 120,
//             width: 120,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Expanded(
//                     child: Text(
//                   '${article['title']}',
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                   style: Theme.of(context).textTheme.labelLarge,
//                 )),
//                 const SizedBox(height: 5),
//                 Text(
//                   '${article['author'] == null ? '' : article['author']}',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//                 Text(
//                     DateFormat().add_yMMMMEEEEd().format(
//                           DateTime.parse(
//                             article['publishedAt'],
//                           ),
//                         ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context).textTheme.bodySmall),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

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
        // navigateToScreen(
        //   screen: WebViewNewsScreen(
        //     url: article['url'],
        //   ),
        //   context: context,
        // );
        final Uri url = Uri.parse(article['url']);
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
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
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 4,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      DateFormat().add_yMMMMEEEEd().format(
                            DateTime.parse(
                              article['publishedAt'],
                            ),
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w100,
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

class DropListWidget extends StatelessWidget {
  String? value;
  List<DropdownMenuItem<String>>? items;
  ValueChanged<String?>? onChange;

  DropListWidget({
    Key? key,
    required this.value,
    required this.items,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => DropdownButton(
        alignment: Alignment.center,
        underline: Container(
          color: Colors.transparent,
        ),
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
        ),
        dropdownColor: Color(0xFFE3E3E3),
        borderRadius: BorderRadius.circular(10),
        value: value,
        items: items,
        style: Theme.of(context).textTheme.labelLarge,
        onChanged: (String? newValue) {
          onChange!(newValue);
        },
      );
}

Widget pSizeBoxHeight20() =>  SizedBox(height: 20.sp);

Widget pSizeBoxWidth10() => const SizedBox(width: 10);
