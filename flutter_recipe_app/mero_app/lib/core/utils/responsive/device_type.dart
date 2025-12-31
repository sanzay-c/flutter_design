import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceType {
  static bool get isTablet => 1.sw > 600;
  static bool get isDesktop => 1.sw > 1000;
  static bool get isMobile => 1.sw <= 600;
}