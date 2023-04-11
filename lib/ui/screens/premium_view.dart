import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/ui/widgets/black_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumView extends StatefulWidget {
  const PremiumView({Key? key}) : super(key: key);

  @override
  State<PremiumView> createState() => _PremiumViewState();
}

class _PremiumViewState extends State<PremiumView> {
  bool isWhitePlateSelected = false;
  bool isBluePlateSelected = false;

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: heightScreen * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: ExpandTapWidget(
                tapPadding: const EdgeInsets.all(100),
                onTap: () => context.read<AppBloc>().add(
                      const AppEventGoToSettings(),
                    ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    AppIcons.close,
                    scale: 3,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: heightScreen * 0.03,
            ),
            Center(
              child: Image.asset(
                AppIcons.diamond,
                scale: 3,
              ),
            ),
            SizedBox(
              height: heightScreen * 0.01,
            ),
            Center(
              child: Text(
                S.of(context).getPremium,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: ListView(shrinkWrap: true, children: [
                pros(S.of(context).premTasks),
                pros(S.of(context).premColorsQuotes),
                pros(S.of(context).premLists),
                pros(S.of(context).premFuture),
              ]),
            ),
            SizedBox(
              height: heightScreen * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widthScreen * 0.07,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      isBluePlateSelected = false;
                      isWhitePlateSelected = !isWhitePlateSelected;
                    }),
                    child: Container(
                      height: heightScreen * 0.15,
                      width: heightScreen * 0.15,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: isWhitePlateSelected
                                  ? const AssetImage(
                                      AppIcons.whitePlateSelected)
                                  : const AssetImage(AppIcons.whitePlate),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: [
                          Positioned(
                            top: heightScreen * 0.045,
                            left: widthScreen * 0.11,
                            child: const Text(
                              PremiumPageStrings.monthlyPrice,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                          ),
                          Positioned(
                              top: heightScreen * 0.09,
                              left: widthScreen * 0.08,
                              child: Text(
                                S.of(context).perMonth,
                                style: const TextStyle(fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      isWhitePlateSelected = false;
                      isBluePlateSelected = !isBluePlateSelected;
                    }),
                    child: Container(
                      height: heightScreen * 0.15,
                      width: heightScreen * 0.15,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: isBluePlateSelected
                                  ? const AssetImage(
                                      AppIcons.bluePlateSelected,
                                    )
                                  : const AssetImage(AppIcons.bluePlate),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: [
                          Positioned(
                            top: heightScreen * 0.045,
                            left: widthScreen * 0.11,
                            child: const Text(
                              PremiumPageStrings.yearlyPrice,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                          ),
                          Positioned(
                              top: heightScreen * 0.09,
                              left: widthScreen * 0.1,
                              child: Text(
                                S.of(context).perYear,
                                style: const TextStyle(fontSize: 16),
                              )),
                          Positioned(
                              left: widthScreen * 0.2,
                              child: Image.asset(
                                AppIcons.lightning,
                                scale: 3,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: heightScreen * 0.04,
            ),
            Center(
              child: Text(
                S.of(context).recurringPayment,
                style: const TextStyle(
                  fontSize: 14,
                  color: recurringPaymentColor,
                ),
              ),
            ),
            SizedBox(
              height: heightScreen * 0.04,
            ),
            BlackButtonWidget(
                onPressed: () {},
                width: widthScreen * 0.75,
                height: heightScreen * 0.07,
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: Text(
                    S.of(context).goPremium,
                    style: const TextStyle(
                      fontSize: 20,
                      color: backgroundColor,
                    ),
                  ),
                )),
            SizedBox(
              height: heightScreen * 0.02,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: S.of(context).bySubscribing,
                    style: const TextStyle(
                      color: recurringPaymentColor,
                    ),
                    children: [
                      TextSpan(
                        text: S.of(context).privacyPolicyPremium,
                        style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          _launchURL(S.of(context).linkPrivacyPolicy);
                        },
                      ),
                      TextSpan(
                          text: S.of(context).and,
                          style: const TextStyle(
                            color: recurringPaymentColor,
                          )),
                      TextSpan(
                        text: S.of(context).terms,
                        style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          _launchURL(S.of(context).linkTermsOfUsing);
                        },
                      )
                    ]))
          ],
        ),
      ),
    );
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

  Widget pros(String text) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        AppIcons.userPoint,
        scale: 3,
      ),
      title: Transform.translate(
        offset: const Offset(-40, -8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
