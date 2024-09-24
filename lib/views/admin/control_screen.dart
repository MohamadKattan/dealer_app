import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_btn.dart';
import 'package:dealer/router/router_app.gr.dart';
import 'package:dealer/utilities/ui_res_app/ui_responsev_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StackRouter router = context.router;
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(35.0),
            child: CustomScrollView(
              primary: false,
              slivers: <Widget>[
                Builder(builder: (context) {
                  double width = UiResponsive.globalMedia(context: context);
                  return SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: _valAspectRatio(width),
                      crossAxisCount: _valCrossAxisCount(width),
                      children: <Widget>[
                        AppBtn.cardBtn(
                            function: () =>
                                router.replace(const DbRemoteRoute()),
                            icon: Icons.table_rows,
                            sizeIcon: 40,
                            txt: AppLocalizations.of(context)!.dbSetting),
                        AppBtn.cardBtn(
                            icon: Icons.people_sharp,
                            sizeIcon: 40,
                            txt:
                                AppLocalizations.of(context)!.employesSettings),
                        AppBtn.cardBtn(
                            icon: Icons.store_mall_directory,
                            sizeIcon: 40,
                            txt: AppLocalizations.of(context)!
                                .retailSalesCenters),
                        AppBtn.cardBtn(
                            icon: Icons.storage_rounded,
                            sizeIcon: 40,
                            txt: AppLocalizations.of(context)!
                                .wareHouseSettings),
                        AppBtn.cardBtn(
                            icon: Icons.fire_truck,
                            sizeIcon: 40,
                            txt: AppLocalizations.of(context)!.carSalesCenters),
                        AppBtn.cardBtn(
                            icon: Icons.account_box,
                            sizeIcon: 40,
                            txt: AppLocalizations.of(context)!.coustmersCenters)
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _valAspectRatio(double width) {
    if (width <= ScreenSize.isIpad.width) {
      return 1;
    } else {
      return 2;
    }
  }
}

int _valCrossAxisCount(double width) {
  if (width <= ScreenSize.isMobile.width) {
    return 2;
  } else if (width > ScreenSize.isMobile.width &&
      width < ScreenSize.isLapSmall.width) {
    return 3;
  } else {
    return 4;
  }
}
