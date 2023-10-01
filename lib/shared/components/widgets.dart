import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    onFieldSubmitted: onSubmits,
    onChanged: onChanged,
    obscureText: isPassword,
    // ignore: prefer_const_constructors
    decoration: InputDecoration(
      prefixIconColor: Colors.white,
      suffixIconColor: Colors.white,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon != null
          ? IconButton(onPressed: suffixPressed, icon: suffixIcon)
          : null,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white),
      helperText: helperText,
      helperStyle: const TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    validator: validMsg,
  );
}

navigateToScreen({required Widget screen, required BuildContext context}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

Widget buildArticleItems({article, context}) => InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: article['urlToImage'] != null
                        ? DecorationImage(
                            image: NetworkImage('${article['urlToImage']}'),
                            fit: BoxFit.cover)
                        : const DecorationImage(
                            image: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'),
                          ))),
            const SizedBox(
              width: 20,
            ),
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
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
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
                      style: TextStyle(
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
        {list, context, required int itemCount, isSearch = false}) =>
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
  bool isExpanded = true;
  double? height = 19.55;
  double? width = 190;

  DropListWidget({
    Key? key,
    required this.value,
    required this.items,
    required this.onChange,
    this.isExpanded = true,
    this.height = 19.55,
    this.width = 190,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: width?.spMin,
        height: height?.sp,
        // margin: const EdgeInsets.only(
        //   top: 5.0,
        //   right: 15.0,
        //   bottom: 5.0,
        //   left: 15.0,
        // ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: const Offset(0, 0.5),
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButton(
          alignment: Alignment.center,
          isExpanded: isExpanded,
          underline: Container(
            color: Colors.transparent,
          ),
          icon: const Icon(
            Icons.arrow_drop_down_rounded,
          ),
          borderRadius: BorderRadius.circular(10),
          value: value,
          items: items,
          onChanged: (String? newValue) {
            onChange!(newValue);
          },
        ),
      );
}
