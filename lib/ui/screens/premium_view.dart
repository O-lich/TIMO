import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/ui/widgets/black_button_widget.dart';

class PremiumView extends StatelessWidget {

  const PremiumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: heightScreen * 0.017,
              top: heightScreen * 0.060,
              left: 25,
              right: 25),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => context.read<AppBloc>().add(
                     AppEventGoToSettingsFromPremiumView(context: context),
                  ),
                  child: Image.asset(
                    AppIcons.close,
                    scale: 3,
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
                padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.04),
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
                    Container(
                      height: heightScreen * 0.15,
                      width: heightScreen * 0.15,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppIcons.whitePlate),
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
                    Container(
                      height: heightScreen * 0.15,
                      width: heightScreen * 0.15,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppIcons.bluePlate),
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
                            fontWeight: FontWeight.w800,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
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
                            fontWeight: FontWeight.w800,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        )
                      ]))
            ],
          ),
        ),
      ),
    );
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
