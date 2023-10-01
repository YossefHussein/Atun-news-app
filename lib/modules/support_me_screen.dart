import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:news_app/shared/bloc/cubit.dart';
import 'package:news_app/shared/bloc/states.dart';
import 'package:news_app/shared/components/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportMeScreen extends StatelessWidget {
  const SupportMeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'This is not should to do If You want support me \n You can do it from these app',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                pSizeBoxHeight20(),
                /**
                 * support in paypal
                 ***/
                GestureDetector(
                  onTap: () => openWebsite(
                      'https://www.paypal.com/paypalme/my/settings/?flow=cmV0dXJuVXJsPS9teWFjY291bnQvcHJvZmlsZSZjYW5jZWxVcmw9L215YWNjb3VudC9wcm9maWxl'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(Logos.paypal),
                      pSizeboxWidth10(),
                      const Text(
                          'Support me with paypal \n User name: yousefhussein222')
                    ],
                  ),
                ),
                pSizeBoxHeight20(),
                GestureDetector(
                  onTap: () => openWebsite(
                      'https://www.buymeacoffee.com/youssefHussein23'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(Logos.buymeacoffee),
                      pSizeboxWidth10(),
                      const Text(
                          'Support me with buyMeACoffe \n User name: youssefhussein23')
                    ],
                  ),
                ),
                pSizeBoxHeight20(),
                GestureDetector(
                  onTap: () => openWebsite('https://twitter.com/yhussein2099'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(Logos.twitter),
                      pSizeboxWidth10(),
                      const Text(
                          'My twitter account \n User name: yhussein2099')
                    ],
                  ),
                ),
                pSizeBoxHeight20(),
                GestureDetector(
                  onTap: () => openWebsite('https://github.com/YossefHussein'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(Logos.github),
                      pSizeboxWidth10(),
                      const Text(
                          'My projects on github \n User name: YossefHussein')
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  SizedBox pSizeboxWidth10() => SizedBox(
        width: 10,
      );
}

openWebsite(websiteUrlOpen) async {
  final Uri url = Uri.parse(websiteUrlOpen);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
