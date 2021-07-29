import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyricious/src/core/utils/extensions.dart';
import 'package:lyricious/src/presentation/components/components.dart';
import 'package:lyricious/src/presentation/components/home/header.dart';
import 'package:lyricious/src/presentation/pages/home/cubit/home_page_cubit.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocProvider<HomePageCubit>(
        create: (_) => HomePageCubit(),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(delegate: HomePageHeader()),
            SliverPadding(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              sliver: BlocBuilder<HomePageCubit, HomePageState>(
                builder: (context, state) {
                  final cubit = getCubit<HomePageCubit>(context);

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        if (i == 0)
                          return AppTabs(
                            tabOptions: cubit.tabOptions,
                            activeIndex: state.currentTabOption,
                            onSelect: (index) => cubit.setTabOption(index),
                          );

                        return cubit.tabOptions[state.currentTabOption].bodyBuilder();
                      },
                      childCount: 2,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
