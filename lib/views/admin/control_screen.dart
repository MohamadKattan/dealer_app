import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_btn.dart';
import 'package:dealer/router/router_app.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StackRouter router = context.router;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(35.0),
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2,
                  crossAxisCount: 4,
                  children: <Widget>[
                    AppBtn.cardBtn(
                        function: () => router.push(const DbRemoteRoute()),
                        icon: Icons.table_rows,
                        sizeIcon: 40,
                        txt: AppLocalizations.of(context)!.dbSetting),
                    AppBtn.cardBtn(
                        icon: Icons.people_sharp,
                        sizeIcon: 40,
                        txt: AppLocalizations.of(context)!.employesSettings),
                    AppBtn.cardBtn(
                        icon: Icons.store_mall_directory,
                        sizeIcon: 40,
                        txt: AppLocalizations.of(context)!.retailSalesCenters),
                    AppBtn.cardBtn(
                        icon: Icons.storage_rounded,
                        sizeIcon: 40,
                        txt: AppLocalizations.of(context)!.wareHouseSettings),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
