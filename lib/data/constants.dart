abstract class Constants {
  // Directories
  static final String appDirectoryPath = "/lib/App";
  static final String coreDirectoryPath = "/lib/App/core";
  static final String constantsDirectoryPath = "/lib/App/core/constants";
  static final String providerDirectoryPath = "/lib/App/core/provider";
  static final String screensDirectoryPath = "/lib/App/screens";
  static final String widgetsDirectoryPath = "/lib/App/widgets";
  static final String utilsDirectoryPath = "/lib/App/core/utils";
  static final String themeDirectoryPath = "/lib/App/core/theme";
  static final String routesDirectoryPath = "/lib/App/routes";
  static final String modulesDirectoryPath = "/lib/App/modules";

  // Files
  static final String mainFilePath = "/lib/main.dart";
  static final String appFilePath = "/lib/app.dart";
  static final String pubspecFilePath = "/pubspec.yaml";
  static final String appRoutesPath = "/lib/App/routes/app_routes.dart";
  static final String routeNavigatorPath = "/lib/App/routes/route_navigator.dart";

  // Constants
  static final String colorConstantsPath = "/lib/App/core/constants/color_constants.dart";
  static final String urlManagerPath = "/lib/App/core/constants/url_manager.dart";

  // Providers
  static final String preferenceProviderPath = "/lib/App/core/provider/preference_provider.dart";
  static final String apiProviderPath = "/lib/App/core/provider/api_provider.dart";

  // Theme
  static final String themeFilePath = "/lib/App/core/theme/theme.dart";

  // Enums
  static final String enumsPath = "/lib/App/core/enums/enums.dart";

  // Utils
  static final String commonUtilsFilePath = "/lib/App/core/utils/common.dart";
  static final String assetImagesPath = "/lib/App/core/utils/asset_images.dart";
  static final String textStyleFilePath = "/lib/App/core/utils/app_text_style.dart";
  static final String mediaUtilsFilePath = "/lib/App/core/utils/media_utils.dart";
  static final String datePickerUtilsFilePath = "/lib/App/core/utils/date_picker_utils.dart";

  // Screens
  static final String baseScreenPathGlobal = "/lib/App/screens/base_screen/view/base_screen.dart";
  static final String baseDialogPathGlobal = "/lib/App/screens/base_screen/view/base_dialog.dart";
  static final String customAppbarPathGlobal = "/lib/App/screens/base_screen/view/custom_appbar.dart";
  static final String splashScreenPathGlobal = "/lib/App/screens/splash_screen/view/splash_screen.dart";
  static final String homeScreenPathGlobal = "/lib/App/screens/home_screen/view/home_screen.dart";
  static final String homeScreenRepositoryPathGlobal = "/lib/App/screens/home_screen/repository/home_screen_repository.dart";
  static final String homeScreenControllerPathGlobal = "/lib/App/screens/home_screen/controller/home_screen_controller.dart";
  static final String homeScreenBindingPathGlobal = "/lib/App/screens/home_screen/binding/home_screen_binding.dart";

  static final String baseScreenPathModular = "/lib/App/modules/shared/base_screen/view/base_screen.dart";
  static final String baseDialogPathModular = "/lib/App/modules/shared/base_screen/view/base_dialog.dart";
  static final String customAppbarPathModular = "/lib/App/modules/shared/base_screen/view/custom_appbar.dart";
  static final String splashScreenPathModular = "/lib/App/modules/splash/splash_screen/view/splash_screen.dart";
  static final String homeScreenPathModular = "/lib/App/modules/dashboard/home_screen/view/home_screen.dart";
  static final String homeScreenRepositoryPathModular = "/lib/App/modules/dashboard/home_screen/repository/home_screen_repository.dart";
  static final String homeScreenControllerPathModular = "/lib/App/modules/dashboard/home_screen/controller/home_screen_controller.dart";
  static final String homeScreenBindingPathModular = "/lib/App/modules/dashboard/home_screen/binding/home_screen_binding.dart";

  // Widgets
  static final String textFieldWidgetPathGlobal = "/lib/App/widgets/app_textfield.dart";
  static final String checkboxWidgetPathGlobal = "/lib/App/widgets/app_checkbox.dart";
  static final String radioButtonWidgetPathGlobal = "/lib/App/widgets/app_radio_button.dart";
  static final String networkImageWidgetPathGlobal = "/lib/App/widgets/app_network_image.dart";
  static final String searchFieldWidgetPathGlobal = "/lib/App/widgets/search_field.dart";
  static final String emptyViewWidgetPathGlobal = "/lib/App/widgets/empty_view.dart";
  static final String backArrowWidgetPathGlobal = "/lib/App/widgets/back_arrow.dart";
  static final String authTextFieldWidgetPathGlobal = "/lib/App/widgets/auth_textfield.dart";
  static final String authSubmitButtonWidgetPathGlobal = "/lib/App/widgets/auth_submit_button.dart";

  static final String textFieldWidgetPathModular = "/lib/App/modules/shared/widgets/app_textfield.dart";
  static final String checkboxWidgetPathModular = "/lib/App/modules/shared/widgets/app_checkbox.dart";
  static final String radioButtonWidgetPathModular = "/lib/App/modules/shared/widgets/app_radio_button.dart";
  static final String networkImageWidgetPathModular = "/lib/App/modules/shared/widgets/app_network_image.dart";
  static final String searchFieldWidgetPathModular = "/lib/App/modules/shared/widgets/search_field.dart";
  static final String emptyViewWidgetPathModular = "/lib/App/modules/shared/widgets/empty_view.dart";
  static final String backArrowWidgetPathModular = "/lib/App/modules/shared/widgets/back_arrow.dart";
  static final String authTextFieldWidgetPathModular = "/lib/App/modules/shared/widgets/auth_textfield.dart";
  static final String authSubmitButtonWidgetPathModular = "/lib/App/modules/shared/widgets/auth_submit_button.dart";

  // Assets
  static final String assetsImageDirectoryPath = "/assets/images";
  static final String assetsEmptyImageFilePath = "/assets/images/empty.png";

  // Auth screens constants
  static final String loginScreen = "login_screen";
  static const String registerScreen = "register_screen";
  static const String forgotPasswordScreen = "forgot_password_screen";
  static const String resetPasswordScreen = "reset_password_screen";
  static const String changePasswordScreen = "change_password_screen";
  static const String otpVerificationScreen = "otp_verification_screen";
  static const String profileSetupScreen = "profile_setup_screen";
  static const String editProfileScreen = "edit_profile_screen";

  static String get nonModularPatternInitDirectoryStructor => """Generated files:\n
/lib
│── /App
│   ├── /core
│   │   ├── /constants
│   │   │   ├── color_constants.dart
│   │   │   ├── url_manager.dart
│   │   ├── /enums
│   │   │   ├── enums.dart
│   │   ├── /provider
│   │   │   ├── api_provider.dart
│   │   │   ├── preference_provider.dart
│   │   ├── /theme
│   │   │   ├── theme.dart
│   │   ├── /utils
│   │   │   ├── app_text_style.dart
│   │   │   ├── asset_images.dart
│   │   │   ├── common.dart
│   │   │   ├── date_picker_utils.dart
│   │   │   ├── media_utils.dart
│   ├── /routes
│   │   ├── app_routes.dart
│   │   ├── route_navigator.dart
│   ├── /screens
│   │   ├── /base_screen
│   │   │   ├── /view
│   │   │   │   ├── base_dialog.dart
│   │   │   │   ├── base_screen.dart
│   │   │   │   ├── custom_appbar.dart
│   │   ├── /home_screen
│   │   │   ├── /controller
│   │   │   │   ├── home_screen_controller.dart
│   │   │   ├── /repository
│   │   │   │   ├── home_screen_repository.dart
│   │   │   ├── /view
│   │   │   │   ├── home_screen.dart
│   │   │   ├── /binding
│   │   │   │   ├── home_screen_binding.dart
│   │   ├── /splash_screen
│   │   │   ├── /view
│   │   │   │   ├── splash_screen.dart
│   ├── /widgets
│   │   ├── app_checkbox.dart
│   │   ├── app_network_image.dart
│   │   ├── app_radio_button.dart
│   │   ├── app_textfield.dart
│   │   ├── back_arrow.dart
│   │   ├── empty_view.dart
│   │   ├── search_field.dart
│   ├── app.dart
│   ├── main.dart
\n\n""";

  static String get modularPatternInitDirectoryStructor => """/lib
│── /App
│   ├── /core
│   │   ├── /constants
│   │   │   ├── color_constants.dart
│   │   │   ├── url_manager.dart
│   │   ├── /enums
│   │   │   ├── enums.dart
│   │   ├── /provider
│   │   │   ├── api_provider.dart
│   │   │   ├── preference_provider.dart
│   │   ├── /theme
│   │   │   ├── theme.dart
│   │   ├── /utils
│   │   │   ├── app_text_style.dart
│   │   │   ├── asset_images.dart
│   │   │   ├── common.dart
│   │   │   ├── date_picker_utils.dart
│   │   │   ├── media_utils.dart
│   ├── /routes
│   │   ├── app_routes.dart
│   │   ├── route_navigator.dart
│   ├── /modules
│   │   ├── /dashboard
│   │   │   ├── /home_screen
│   │   │   │   ├── /controller
│   │   │   │   │   ├── home_screen_controller.dart
│   │   │   │   ├── /repository
│   │   │   │   │   ├── home_screen_repository.dart
│   │   │   │   ├── /view
│   │   │   │   │   ├── home_screen.dart
│   │   │   │   ├── /binding
│   │   │   │   │   ├── home_screen_binding.dart
│   │   ├── /shared
│   │   │   ├── /base_screen
│   │   │   │   ├── /view
│   │   │   │   │   ├── base_dialog.dart
│   │   │   │   │   ├── base_screen.dart
│   │   │   │   │   ├── custom_appbar.dart
│   │   │   ├── /widgets
│   │   │   │   ├── app_checkbox.dart
│   │   │   │   ├── app_network_image.dart
│   │   │   │   ├── app_radio_button.dart
│   │   │   │   ├── app_textfield.dart
│   │   │   │   ├── back_arrow.dart
│   │   │   │   ├── empty_view.dart
│   │   │   │   ├── search_field.dart      
│   │   ├── /splash
│   │   │   ├── /splash_screen
│   │   │   │   ├── /view
│   │   │   │   │   ├── splash_screen.dart
│   ├── app.dart
│   ├── main.dart  
""";
}
