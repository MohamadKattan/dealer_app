import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_icon.dart';
import 'package:dealer/components/app_text.dart';
import 'package:dealer/router/router_app.gr.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/style_app/app_them/bloc/them_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppDrawer {
  static drawer(BuildContext context, bool isArabic) {
    bool isClicked = false;
    StackRouter router = context.router;
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppText.normalText(
                                textAlign: TextAlign.start,
                                padding: 2,
                                AppGetter.isMorning
                                    ? AppLocalizations.of(context)!.goodMorning
                                    : AppLocalizations.of(context)!.goodNight),
                            const SizedBox(width: 4),
                            AppGetter.isMorning
                                ? AppIcon.normalIcon(Icons.sunny,
                                    color: Colors.amberAccent)
                                : AppIcon.normalIcon(Icons.nights_stay_sharp,
                                    color: Colors.white)
                          ],
                        ),
                        AppText.normalText(
                            textAlign: TextAlign.start,
                            padding: 2,
                            AppGetter.userName ?? 'null'),
                        AppText.normalText(
                            textAlign: TextAlign.start,
                            padding: 2,
                            '${AppLocalizations.of(context)!.date} : ${AppGetter.dateOFToday}'),
                      ],
                    ),
                  ),
                  if (AppGetter.per == AppGetter.checkPer)
                    ListTile(
                      leading: AppIcon.normalIcon(Icons.admin_panel_settings),
                      trailing: AppIcon.normalIcon(isArabic
                          ? Icons.arrow_back_ios_new
                          : Icons.arrow_forward_ios),
                      title: AppText.normalText(
                          textAlign: TextAlign.start,
                          AppLocalizations.of(context)!.controlPanel),
                      onTap: () {
                        router.push(const ControlRoute());
                      },
                    ),
                  ListTile(
                    leading: AppIcon.normalIcon(Icons.book),
                    trailing: AppIcon.normalIcon(isArabic
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios),
                    title: AppText.normalText(
                        textAlign: TextAlign.start,
                        AppLocalizations.of(context)!.dailyMovement),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: AppIcon.normalIcon(Icons.storage),
                    trailing: AppIcon.normalIcon(isArabic
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios),
                    title: AppText.normalText(
                        textAlign: TextAlign.start,
                        AppLocalizations.of(context)!.warehouse),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: AppIcon.normalIcon(Icons.people_alt_outlined),
                    trailing: AppIcon.normalIcon(isArabic
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios),
                    title: AppText.normalText(
                        textAlign: TextAlign.start,
                        AppLocalizations.of(context)!.treeOfAccounts),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: AppIcon.normalIcon(Icons.receipt_long_rounded),
                    trailing: AppIcon.normalIcon(isArabic
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios),
                    title: AppText.normalText(
                        textAlign: TextAlign.start,
                        AppLocalizations.of(context)!.bills),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.normalText(
                  textAlign: TextAlign.start,
                  AppLocalizations.of(context)!.darkLight),
              Switch(
                  value: isClicked,
                  onChanged: (bool newval) {
                    isClicked = newval;
                    context.read<ThemeBloc>().toggleTheme();
                  }),
            ],
          ),
          const Divider(),
          Column(
            children: [
              AppText.normalText(
                  padding: 4,
                  'Daeler System\nV1.0.0',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              AppText.normalText(padding: 0, 'Provide by : TEKO CODE'),
              AppText.normalText(
                  padding: 0.0, 'For Technology Solutions', fontSize: 12),
              const SizedBox(height: 40)
            ],
          ),
        ],
      ),
    );
  }
}
