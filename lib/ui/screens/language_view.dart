//import 'dart:developer';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/ui/widgets/black_button_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/language_page_widgets/language_list.dart';

class LanguageView extends StatefulWidget {
  final int selectedIndex;
  static const routeName = '/language_page';

  const LanguageView({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            bottom: heightScreen * 0.017,
            top: heightScreen * 0.060,
            left: 25,
            right: 25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ExpandTapWidget(
                onTap: () => context.read<AppBloc>().add(
                      const AppEventGoToSettings(),
                    ),
                tapPadding: const EdgeInsets.all(50.0),
                child: Image.asset(
                  AppIcons.back,
                  scale: 3,
                ),
              ),
            ),
            SizedBox(
              height: 0.5 * heightScreen,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var language = languageList[index];
                    return InkWell(
                      onTap: () {
                        context.read<AppBloc>().add(
                              AppEventChangeLocale(
                                  context: context, index: index),
                            );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          language.flag,
                          scale: 3,
                        ),
                        title: Text(language.name),
                        trailing: Image.asset(
                          AppIcons.check,
                          scale: 3,
                          color: widget.selectedIndex == index
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: languageList.length),
            ),
            BlackButtonWidget(
                onPressed: () {
                  context.read<AppBloc>().add(
                        const AppEventGoToSettings(),
                      );
                },
                width: widthScreen * 0.5,
                borderRadius: BorderRadius.circular(20),
                height: heightScreen * 0.07,
                child: Text(
                  S.of(context).save,
                  style: const TextStyle(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
