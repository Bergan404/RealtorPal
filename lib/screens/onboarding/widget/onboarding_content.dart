import 'package:dots_indicator/dots_indicator.dart';
import 'package:realtorpal/core/const/color_constants.dart';
import 'package:realtorpal/core/const/data_constants.dart';
import 'package:realtorpal/screens/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<OnboardingBloc>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: _createPageView(bloc.pageController, bloc),
          ),
          Expanded(
            flex: 2,
            child: _createStatic(bloc),
          ),
        ],
      ),
    );
  }

  Widget _createPageView(PageController controller, OnboardingBloc bloc) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: DataConstants.onboardingTiles,
      onPageChanged: (index) {
        bloc.add(PageSwipedEvent(index: index));
      },
    );
  }

 Widget _createStatic(OnboardingBloc bloc) {
  return Column(
    children: [
      const SizedBox(
        height: 30,
      ),
      BlocBuilder<OnboardingBloc, OnboardingState>(
        buildWhen: (_, currState) => currState is PageChangedState,
        builder: (context, state) {
          return DotsIndicator(
            dotsCount: 3,
            position: bloc.pageIndex, // Ensure bloc.pageIndex is an int
            decorator: const DotsDecorator(
              color: Colors.grey,
              activeColor: ColorConstants.primaryColor,
            ),
          );
        },
      ),
      const Spacer(),
      BlocBuilder<OnboardingBloc, OnboardingState>(
        buildWhen: (_, currState) => currState is PageChangedState,
        builder: (context, state) {
          final percent = _getPercent(bloc.pageIndex);
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: percent),
            duration: const Duration(seconds: 1),
            builder: (context, value, _) => CircularPercentIndicator(
              radius: 110,
              backgroundColor: ColorConstants.primaryColor,
              progressColor: Colors.white,
              percent: 1 - value,
              center: Material(
                shape: const CircleBorder(),
                color: ColorConstants.primaryColor,
                child: RawMaterialButton(
                  shape: const CircleBorder(),
                  onPressed: () {
                    bloc.add(PageChangedEvent());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Icon(
                      Icons.east_rounded,
                      size: 38.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      const SizedBox(height: 30),
    ],
  );
  }

  double _getPercent(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return 0.25;
      case 1:
        return 0.65;
      case 2:
        return 1;
      default:
        return 0;
    }
  }
}
