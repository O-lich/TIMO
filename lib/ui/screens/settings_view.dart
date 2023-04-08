import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/ui/widgets/language_page_widgets/language_list.dart';
import 'package:todo_app_main_screen/ui/widgets/settings_page_widgets/settings_widget.dart';

class SettingsView extends StatefulWidget {
  static const routeName = '/settings_page';

  const SettingsView({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(
              height: heightScreen * 0.055,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ExpandTapWidget(
                    tapPadding: const EdgeInsets.all(100.0),
                    onTap: () {
                      context.read<AppBloc>().add(
                        const AppEventGoToLists(),
                      );
                    },
                    child: Image.asset(
                      AppIcons.close,
                      scale: 3,
                    ),
                  ),
                ),
                Text(
                  S.of(context).settings,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: darkColor,
                  ),
                ),
                SizedBox(
                  width: widthScreen * 0.1,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: heightScreen * 0.017,
                top: heightScreen * 0.060,
                left: 25,
                right: 25,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: heightScreen * 0.06,
                  ),
                  InkWell(
                    onTap: () => context.read<AppBloc>().add(
                      const AppEventGoToPremium(),
                    ),
                    child: Center(
                        child: Stack(
                          children: [
                        Positioned(
                            child: Image.asset(
                          AppIcons.vector,
                          scale: 3,
                        )),
                        Positioned(
                          left: widthScreen * 0.07,
                          top: heightScreen * 0.017,
                          child: Row(
                            children: [
                              Image.asset(
                                AppIcons.diamond,
                                scale: 3,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).getPremium,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    S.of(context).allFeatures,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: allFeaturesColor,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 0.9 * heightScreen,
                    child: ListView(
                      children: [
                        SettingsWidget(
                          url: S.of(context).linkAboutUs,
                          title: S.of(context).aboutUs,
                          trailing: settingsImage,
                          navigateTo: () {},
                        ),
                        SettingsWidget(
                          url: '',
                          title: S.of(context).languageTitle,
                          trailing: Text(
                            currentUser.locale >= 0
                                ? languageList[currentUser.locale].name
                                : '',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              color: paleTextColor,
                            ),
                          ),
                          navigateTo: () {
                            context.read<AppBloc>().add(
                                  const AppEventGoToLanguage(),
                                );
                          },
                        ),
                        SettingsWidget(
                          url: '',
                          title: S.of(context).reportProblem,
                          trailing: Container(),
                          navigateTo: () {},
                        ),
                        SettingsWidget(
                          url: S.of(context).linkTermsOfUsing,
                          title: S.of(context).termsOfUsing,
                          trailing: settingsImage,
                          navigateTo: () {},
                        ),
                        SettingsWidget(
                          url: S.of(context).linkPrivacyPolicy,
                          title: S.of(context).privacyPolicy,
                          trailing: settingsImage,
                          navigateTo: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
