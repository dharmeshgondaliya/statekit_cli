abstract class InitGenerator {
  static const String mainFileContent = """import 'package:flutter/material.dart';
import 'package:<app_name>/app.dart';

void main() {
  runApp(const MyApp());
}""";

  static const String appFileContent = """import 'package:flutter/material.dart';
import 'package:<app_name>/App/routes/app_routes.dart';
import 'package:<app_name>/App/routes/route_navigator.dart';
import 'App/core/theme/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initial,
      routes: RouteNavigator.routes,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}""";

  static const String appRoutesFileContent = """abstract class Routes {
  static const String initial = splash;

  static const String splash = "/";
  static const String homeScreen = "/homeScreen";
}""";

  static const colorConstantsFileContent = """import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Colors.green;
  static const Color secondaryColor = Colors.blue;
  static const Color backgroundColor = Colors.white;
}""";

  static const assetImagesFileContent = """class AssetImages {
  static const String _assetpath = "assets/images";
  static const String logo = "\$_assetpath/logo.png";
  static const String empty = "\$_assetpath/empty.png";
}""";

  static const String splashScreenFileContent = """import 'package:<app_name>/App/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushNamed(context, Routes.homeScreen),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: MediaQuery.sizeOf(context).width * 0.5),
      ),
    );
  }
}""";

  static const String homeScreenRepositoryFileContent = "class HomeScreenRepository {}";

  static const String homeScreenControllerFileContent = """import 'package:statekit/statekit.dart';
import '../repository/home_screen_repository.dart';
import '../binding/home_screen_binding.dart';

class HomeScreenController extends StateController<HomeScreenBinding> {
  final HomeScreenRepository _repository = HomeScreenRepository();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}""";

  static const String homeScreenBindingFileContent = """import 'package:statekit/statekit.dart';

abstract interface class HomeScreenBinding implements StateBinding {
  void doSomething();
}""";

  static const String baseDialogFileContent = """import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    this.padding,
    this.width = double.infinity,
    this.height,
    required this.child,
  });
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),      
      child: IntrinsicHeight(
        child: Container(
          width: width,
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),            
          ),
          padding: padding ?? const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}""";

  static const String customAppbarFileContent = """import 'package:<app_name>/App/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
  });

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}""";

  static const String searchFieldWidgetFileContent = """import 'dart:async';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.searchController, this.onTextChange});
  final TextEditingController searchController;
  final Function(String text)? onTextChange;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  double height = 40;
  bool showClearIcon = false;
  Timer? _timer;

  @override
  void initState() {
    showClearIcon = widget.searchController.text.trim().isNotEmpty;
    super.initState();
  }

  void onTextChange(String text) {
    if (text.isEmpty && showClearIcon) {
      showClearIcon = false;
      setState(() {});
    } else if (text.isNotEmpty && !showClearIcon) {
      showClearIcon = true;
      setState(() {});
    }
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 300), () => widget.onTextChange?.call(text));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.maxFinite,
      child: TextField(
        controller: widget.searchController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade300,
          suffixIconConstraints: BoxConstraints(maxWidth: height, minWidth: height, maxHeight: height, minHeight: height),
          constraints: BoxConstraints(minWidth: double.maxFinite, maxWidth: double.maxFinite, maxHeight: height, minHeight: height),
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          hintText: "Search...",
          prefixIcon: const Icon(Icons.search_outlined),
          suffixIcon: showClearIcon
              ? InkWell(
                  onTap: () {
                    widget.searchController.clear();
                    onTextChange("");
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: const Icon(Icons.close_outlined, size: 15),
                    ),
                  ),
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
        onChanged: (value) {
          onTextChange(value.trim());
        },
      ),
    );
  }
}""";

  static const String emptyWidgetFileContent = """import 'package:flutter/material.dart';
import 'package:<app_name>/App/core/utils/asset_images.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, this.assetImage, this.titleText});

  final String? assetImage;
  final String? titleText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetImage ?? AssetImages.empty,
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(titleText ?? "No Data Found")
        ],
      ),
    );
  }
}""";

  static const String backArrowWidgetFileContent = """import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap ?? () => Navigator.pop(context),
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_outlined, color: Colors.black),
        ),
      ),
    );
  }
}""";

  static const String commonUtilsFileContent = """import 'package:flutter/material.dart';

void removeFocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

bool isValidEmail(String email) {
  return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}\$')
      .hasMatch(email);
}

bool isValidPassword(String password) {
  return RegExp(r'^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d\\W_]{6,}\$')
      .hasMatch(password);
}""";

  static const String mediaUtilsFileContent = """import 'dart:io';
import 'package:file_picker/file_picker.dart';

class MediaUtil {
  static Future<File?> selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    String? path = result?.files.firstOrNull?.path;
    if (path == null) return null;
    return File(path);
  }

  static Future<List<File>?> selectImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
    return result?.files.where((element) => element.path != null).map((e) => File(e.path!)).toList();
  }

  static Future<File?> selectVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);
    String? path = result?.files.firstOrNull?.path;
    if (path == null) return null;
    return File(path);
  }
}""";

  static const String datePickerUtilsFileContent = """import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DatePickerUtils on BuildContext {
  Future<DateTime?> selectDate({DateTime? firstDate, DateTime? lastDate, DateTime? initialDate}) async {
    return await showDatePicker(
      context: this,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: DateTime.now(),
      initialDate: initialDate ?? DateTime(2000, 01, 01),
    );
  }
}

extension DateUtil on String {
  String? get toTime {
    DateTime? date = DateTime.tryParse(this);
    if (date == null) return null;
    return DateFormat('hh:mm a').format(date);
  }

  String? get toDate {
    DateTime? date = DateTime.tryParse(this);
    if (date == null) return null;
    return DateFormat('dd/MM/yyyy').format(date);
  }
}""";

  static const String checkboxWidgetFileContent = """import 'package:<app_name>/App/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final bool value;
  final void Function(bool? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primaryColor,
    );
  }
}""";

  static const String networkImageWidgetFileContent = """import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    required this.placeholderAssetImage,
    this.errorAssetImage,
    this.height,
    this.width,
    this.fit,
  });

  final String imageUrl;
  final String placeholderAssetImage;
  final String? errorAssetImage;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      alignment: Alignment.center,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) {
        return Image.asset(
          placeholderAssetImage,
          width: width,
          height: height,
          alignment: Alignment.center,
          fit: fit ?? BoxFit.cover,
        );
      },
      errorWidget: (context, url, error) {
        return Image.asset(
          errorAssetImage ?? placeholderAssetImage,
          width: width,
          height: height,
          alignment: Alignment.center,
          fit: fit ?? BoxFit.cover,
        );
      },
    );
  }
}""";

  static const String radioButtonWidgetFileContent = """import 'package:<app_name>/App/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppRadioButton<T> extends StatelessWidget {
  const AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });
  final T? value;
  final T? groupValue;
  final void Function(T? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Radio(
      value: value,
      groupValue: groupValue,
      activeColor: AppColors.primaryColor,
      hoverColor: AppColors.primaryColor,
      onChanged: (value) {
        onChanged.call(value);
      },
    );
  }
}""";

  static const String textfieldWidgetFileContent = """import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    this.height = 40,
    this.width = double.infinity,
    this.autofocus = false,
    this.controller,
    this.enabled,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.minLines = 1,
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.readOnly = false,
    this.style,
    this.textInputAction,
    this.validator,
    this.fillColor,
    this.errorStyle,
    this.hintStyle,
    this.hintText,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.textFieldErrorborder,
    this.textFieldborder,
  });
  final double width;
  final double height;
  final bool autofocus;
  final TextEditingController? controller;
  final bool? enabled;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int minLines;
  final int? maxLines;
  final int? maxLength;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final bool readOnly;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final String? hintText;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final InputBorder? textFieldborder;
  final InputBorder? textFieldErrorborder;

  final InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: Colors.black54, width: 0.8),
  );
  final InputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: Colors.red, width: 0.8),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        autofocus: autofocus,
        controller: controller,
        cursorColor: Theme.of(context).colorScheme.primary,
        enabled: enabled,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        obscureText: obscureText,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        onTap: onTap,
        readOnly: readOnly,
        style: style,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: textInputAction,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          counterText: "",
          errorStyle: errorStyle,
          fillColor: fillColor,
          filled: false,
          hintStyle: hintStyle,
          hintText: hintText,
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffix: suffix,
          suffixIcon: suffixIcon,
          border: textFieldborder ?? border,
          enabledBorder: textFieldborder ?? border,
          focusedBorder: textFieldborder ?? border,
          disabledBorder: textFieldborder ?? border,
          errorBorder: textFieldErrorborder ?? errorBorder,
          focusedErrorBorder: textFieldErrorborder ?? errorBorder,
        ),
      ),
    );
  }
}""";

  static const String textStyleFileContent = """import 'package:flutter/material.dart';

class AppTextStyle {
  static const String? _fontFamily = null;

  static TextStyle regularBlack({double? fontSize, TextOverflow? overflow}) {
    return _baseStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      overflow: overflow,
    );
  }

  static TextStyle mediumBlack({double? fontSize, TextOverflow? overflow}) {
    return _baseStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      overflow: overflow,
    );
  }

  static TextStyle semiBoldBlack({double? fontSize, TextOverflow? overflow}) {
    return _baseStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      overflow: overflow,
    );
  }

  static TextStyle boldBlack({double? fontSize, TextOverflow? overflow}) {
    return _baseStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      overflow: overflow,
    );
  }

  static TextStyle _baseStyle({
    double? fontSize,
    Color? color,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: _fontFamily,
      fontWeight: fontWeight,
      overflow: overflow,
    );
  }
}""";

  static const String urlManagerFileContent = """class UrlManager {
  static final UrlManager _urlManager = UrlManager._();
  UrlManager._();
  static UrlManager get instance => _urlManager;

  String _baseUrl = "https://www.example.com/";
  String _token = "";

  set setBaseUrl(String url) => _baseUrl = url;

  String get baseUrl => _baseUrl;

  set setToken(String token) => _token = token;

  String get token => _token;
}""";

  static const String enumsFileContent = """enum ActivityState { initial, loading, loaded, empty, error }""";

  static const String preferenceProviderFileContent = """import 'package:shared_preferences/shared_preferences.dart';

class PreferenceProvider {
  static final PreferenceProvider _appPreference =
      PreferenceProvider._internal();

  PreferenceProvider._internal();

  static PreferenceProvider get instance => _appPreference;

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  String getString(String key, {String defaultValue = ""}) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  Future<void> clearPreference() async {
    await _prefs?.clear();
  }
}""";

  static const String apiProviderFileContent = """import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../constants/url_manager.dart';

class ApiProvider {
  static final ApiProvider _apiProvider = ApiProvider._internal();
  ApiProvider._internal();
  static ApiProvider get instance => _apiProvider;

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    String url = "\${UrlManager.instance.baseUrl}\$endPoint";
    try {
      var response = await http.get(Uri.parse(url));
      return jsonDecode(response.body);
    } on SocketException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint, required Map<String, dynamic> params}) async {
    String url = "\${UrlManager.instance.baseUrl}\$endPoint";
    try {
      var response = await http.post(Uri.parse(url), body: jsonEncode(params));
      return jsonDecode(response.body);
    } on SocketException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRequest({required String endPoint}) async {
    String url = "\${UrlManager.instance.baseUrl}\$endPoint";
    Map<String, String> headers = {
      // 'authorization': UrlManager.instance.token
    };
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      return jsonDecode(response.body);
    } on SocketException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postRequest(
      {required String endPoint, required Map<String, dynamic> params}) async {
    String url = "\${UrlManager.instance.baseUrl}\$endPoint";
    Map<String, String> headers = {
      // 'authorization': UrlManager.instance.token
    };
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(params),
      );
      return jsonDecode(response.body);
    } on SocketException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }
}""";

  static const String themeFileContent = """import 'package:flutter/material.dart';

// Light Theme
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(),
);

// Dark Theme
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(),
);""";
}
