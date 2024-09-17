import 'package:realtorpal/core/const/path_constants.dart';
import 'package:realtorpal/core/const/text_constants.dart';
// import 'package:realtorpal/data/exercise_data.dart';
// import 'package:realtorpal/data/workout_data.dart';
import 'package:realtorpal/screens/onboarding/widget/onboarding_tile.dart';

class DataConstants {
   // Onboarding
  static final onboardingTiles = [
    OnboardingTile(
      title: TextConstants.onboarding1Title,
      mainText: TextConstants.onboarding1Description,
      imagePath: PathConstants.onboarding1,
    ),
    OnboardingTile(
      title: TextConstants.onboarding2Title,
      mainText: TextConstants.onboarding2Description,
      imagePath: PathConstants.onboarding2,
    ),
    OnboardingTile(
      title: TextConstants.onboarding3Title,
      mainText: TextConstants.onboarding3Description,
      imagePath: PathConstants.onboarding3,
    ),
  ];
}
