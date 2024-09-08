import 'package:dealer/components/app_icon.dart';
import 'package:dealer/components/app_text.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/style_app/app_them/bloc/them_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer {
  static drawer(BuildContext context, bool isArabic) {
    bool isClicked = false;
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
                                padding: 2,
                                AppGetter.isMorning
                                    ? 'Good Morning'
                                    : 'Good Evening'),
                            const SizedBox(width: 4),
                            AppGetter.isMorning
                                ? AppIcon.normalIcon(Icons.sunny,
                                    color: Colors.amberAccent)
                                : AppIcon.normalIcon(Icons.nights_stay_sharp,
                                    color: Colors.white)
                          ],
                        ),
                        AppText.normalText(
                            padding: 2, AppGetter.userName ?? 'null'),
                        AppText.normalText(
                            padding: 2, 'Date : ${AppGetter.dateOFToday}'),
                      ],
                    ),
                  ),
                  if (AppGetter.per == AppGetter.checkPer)
                    ListTile(
                      leading: AppIcon.normalIcon(Icons.admin_panel_settings),
                      trailing: AppIcon.normalIcon(isArabic
                          ? Icons.arrow_back_ios_new
                          : Icons.arrow_forward_ios),
                      title: const Text('Control Panel'),
                      onTap: () {},
                    ),
                  ListTile(
                    leading: AppIcon.normalIcon(Icons.book),
                    trailing: AppIcon.normalIcon(isArabic
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios),
                    title: const Text('dayle book'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: AppIcon.normalIcon(Icons.storage),
                    trailing: AppIcon.normalIcon(isArabic
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios),
                    title: const Text('Storages'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: AppIcon.normalIcon(Icons.people_alt_outlined),
                    trailing: AppIcon.normalIcon(isArabic
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios),
                    title: const Text('Coustmer tree'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: AppIcon.normalIcon(Icons.receipt_long_rounded),
                    trailing: AppIcon.normalIcon(isArabic
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios),
                    title: const Text('Balles'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.normalText('Light Mode/Dark Mode'),
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
                  padding: 0.0, 'For tecnolejgy solotions', fontSize: 14),
              const SizedBox(height: 40)
            ],
          )
        ],
      ),
    );
  }
}
