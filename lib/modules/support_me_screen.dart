import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:news_app/shared/bloc/cubit.dart';
import 'package:news_app/shared/bloc/states.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportMeScreen extends StatelessWidget {
 const  SupportMeScreen({Key? key}) : super(key: key);

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
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => openWebsite(
                                  'https://www.paypal.com/myaccount/profile/'),
                              icon: Logo(Logos.paypal),
                            ),
                            const Text('Support me with paypal')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => openWebsite(
                                  'https://www.buymeacoffee.com/youssefHussein23'),
                              icon: Logo(Logos.buymeacoffee),
                            ),
                            const Text('Support me with buyMeACoffe')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => openWebsite(
                                  'https://twitter.com/yhussein2099'),
                              icon: Logo(Logos.twitter),
                            ),
                            const Text('My twitter account')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => openWebsite(
                                  'https://github.com/YossefHussein/news_app'),
                              icon: Logo(Logos.github),
                            ),
                            const Text('This project on github')
                          ],
                        ),
        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

openWebsite(websiteUrlOpen) async {
  final Uri url = Uri.parse(websiteUrlOpen);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
