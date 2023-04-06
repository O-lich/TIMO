import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsWidget extends StatelessWidget {
  final String title;
  final Widget trailing;
  final void Function() navigateTo;
  final String url;

  const SettingsWidget({
    Key? key,
    required this.title,
    required this.trailing,
    required this.url,
    required this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => url.isNotEmpty ? _launchURL(url) : navigateTo(),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: darkColor,
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  } else {
    throw 'Could not launch $url';
  }
}

Widget settingsImage = Image.asset(
  AppIcons.link,
  scale: 3,
);
